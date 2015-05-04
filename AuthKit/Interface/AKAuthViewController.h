//
//  AKAuthViewController.h
//  AuthKit
//
//  Created by Dal Rupnik on 25/07/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Haystack/Haystack.h>
#import <AKPickerView/AKPickerView.h>

#import "AKCore.h"

@class AKAuthViewController;

#pragma mark - Delegate

@protocol AKAuthViewControllerDelegate <NSObject>

@optional

/*!
 *  Called when user enters wrong credentials, or another server error appears
 *
 *  @param authViewController AKAuthViewController responsible for error
 *  @param source             AKLoginSource that failed authentication
 *  @param error              NSError object
 */
- (void)authViewController:(AKAuthViewController *)authViewController authenticationFailedForSource:(id<AKLoginSource>)source error:(NSError *)error;

/*!
 *  Called when user enters correct credentials to a login service
 *
 *  @param authViewController AKAuthViewController responsible for logging in
 *  @param source             AKLoginSource that authorized user
 *  @param userDetails        Serialized object of logged in user details
 */
- (void)authViewController:(AKAuthViewController *)authViewController authenticationSuccessForSource:(id<AKLoginSource>)source userDetails:(id)userDetails;

/*!
 *  Called when: user taps the close button; multiple login is not allowed and one login was successful.
 *  View controller does not dismiss itself, that is it's delegate responsibility.
 *
 *  @param authViewController AKAuthViewController that finished
 */
- (void)authViewControllerDidFinish:(AKAuthViewController *)authViewController;

@end

/*!
 *  Main authorization class, easily subclassable
 */
@interface AKAuthViewController : UIViewController

#pragma mark - Main methods

/*!
 *  Delegate that will receive messages
 */
@property (nonatomic, weak) id<AKAuthViewControllerDelegate> delegate;

/*!
 *  Gets or sets the login sources for the view controller.
 */
@property (nonatomic, strong) NSArray* loginSources;

/*!
 *  Gets or sets the login source into the view controller
 */
@property (nonatomic, strong) id<AKLoginSource> selectedLoginSource;

/*!
 *  Array of login service details that were successfully logined by the user
 */
@property (nonatomic, readonly) NSArray* loginServiceDetails;

/*!
 * Displays a close button and allows user to close the controller.
 *
 * Default: YES
 */
@property (nonatomic, getter = isDismissable) BOOL dismissable;

/*!
 *  Allows user to login into multiple services, if dismissable is set to YES.
 *
 * Default: NO
 */
@property (nonatomic) BOOL allowsMultipleLogin;

#pragma mark - UI exposed for subclassing / modifying

//
// View elements that can be modified, but be careful, because they are explicitly set when view loads.
// Additional views can be added to the view controller dynamically
//

/*!
 * ImageView for header, used to display logo, or login icon
 */
@property (nonatomic, strong) UIImageView *headerImageView;

/*!
 *  Username/email text field
 */
@property (nonatomic, strong) UITextField *usernameTextField;

/*!
 *  Password text field
 */
@property (nonatomic, strong) UITextField *passwordTextField;

/*!
 *  Label placed between service picker and password text field
 */
@property (nonatomic, strong) UILabel *descriptionLabel;

/*!
 *  Service picker allows user selection of different services to login
 */
@property (nonatomic, strong) AKPickerView *servicePickerView;

/*!
 *  Login button
 */
@property (nonatomic, strong) UIButton *loginButton;

/*!
 *  Close button
 */
@property (nonatomic, strong) UIButton *closeButton;

#pragma mark - Initializers

/*!
 *  Designated initializer creates a AKAuthViewController with provided login sources.
 *
 *  @param loginSources Login sources to include in AKAuthViewController
 *
 *  @return Initialized View Controller
 */
- (instancetype)initWithLoginSources:(NSArray *)loginSources;

/*!
 *  Initializer pulls login sources out of AKClientManager instance
 *
 *  @param manager AKClientManager
 *
 *  @return Initialized View Controller
 */
- (instancetype)initWithClientManager:(AKClientManager *)manager;

@end