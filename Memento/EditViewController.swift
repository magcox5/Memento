//
//  EditViewController.swift
//  PickImageExperiment
//
//  Created by Molly Cox on 4/4/16.
//  Copyright © 2016 Molly Cox. All rights reserved.
//


import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // Variables
    let memesList = MemesList.sharedInstance

    let memeTextAttributes: [String: AnyObject] = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSBackgroundColorAttributeName : UIColor.clearColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSStrokeWidthAttributeName : -3.0
    ]

    let defaultTopText = "TOP"
    let defaultBottomText = "BOTTOM"

    // Set Text Field to Original values
    func resetTextField(textField: UITextField, defaultText: String) {
        textField.text = defaultText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.textColor = UIColor.whiteColor()
        textField.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTextField(topTitle, defaultText: defaultTopText)
        resetTextField(bottomTitle, defaultText: defaultBottomText)
        topTitle.delegate = self
        bottomTitle.delegate = self
     }

    override func viewWillAppear(animated: Bool) {
        // Disable the camera button if no camera exists
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    // Outlets

    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var topTitle: UITextField!
    
    @IBOutlet weak var bottomTitle: UITextField!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var chooseButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var textStyleButton: UIBarButtonItem!
    

    // Actions
    
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        if sender == chooseButton {
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else {
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        }
        pickerController.delegate = self
        presentViewController(pickerController, animated: true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
        navigationItem.leftBarButtonItem!.enabled = true
    }


    @IBAction func shareMeme(sender: AnyObject) {
        //Create a variable to generate a memed image
        let imageToShare = generateMemedImage()
        //Define an instance of the ActivityViewController
        //& pass the ActivityViewController a memedImage as an activity item
        let memeAVController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        //Present the ActivityViewController
        presentViewController(memeAVController, animated: true, completion: nil)
        
        //If the action completed successfully, save the meme
        memeAVController.completionWithItemsHandler = {(activityType, completed:Bool, returnedItems:[AnyObject]?, error: NSError?) in
            
            // Return if cancelled
            if (completed) {
                self.save()
            }
            self.dismissViewControllerAnimated(true, completion:nil)
        }
        
    }
    
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
}
    

    // Subscribe to keyboard notifications so keyboard can be 
    // moved up when editing bottom title
    func subscribeToKeyboardNotifications() {        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditViewController.keyboardWillShow(_:))    ,
        name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditViewController.keyboardWillHide(_:))    ,
           name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)

    }

    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y = getKeyboardHeight(notification) * -1
    }
    
    func keyboardWillHide(notification: NSNotification) {
        // Reset to original position
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        if bottomTitle.editing {
            return keyboardSize.CGRectValue().height
        }
        else {
            return 0
        }
    }
    
    // Text Field Delegate Methods
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // Figure out what the new text will be, if we return true
        var newText: NSString = textField.text!
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        // returning true gives the text field permission to change its text
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        resignFirstResponder()
        return true
    }
    
    // methods for generating and saving the meme
    func save() {
        // Create the meme
        let meme = Meme( topText: topTitle.text!, bottomText:  bottomTitle.text!, originalImage: self.memeImageView.image, memeImage: generateMemedImage())
        self.memesList.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        navBar.hidden = true
        toolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //  Show toolbar and navbar
        navigationController?.navigationBarHidden = false
        toolBar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    
    // method to pass view controller to textModifyVC
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ModifyTextStyle" {
            let secondViewController = segue.destinationViewController as! ModifyTextStyleVC
            secondViewController.firstViewController = self
        }
    }
}

