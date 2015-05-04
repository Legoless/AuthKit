//
//  AKAuthViewController.m
//  AuthKit
//
//  Created by Dal Rupnik on 25/07/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <PureLayout/PureLayout.h>

#import "AKOAuth.h"
#import "AKClientManager.h"
#import "AKAuthViewController.h"

@interface AKAuthViewController () <UITextFieldDelegate, AKPickerViewDelegate, AKPickerViewDataSource>

@property (nonatomic) BOOL didSetupConstraints;
@property (nonatomic, strong) NSMutableArray *loginDetails;

@property (nonatomic, strong) NSLayoutConstraint *descriptionLabelConstraint;

@end

@implementation AKAuthViewController

#pragma mark - Getters and Setters

- (UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc] initForAutoLayout];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _headerImageView;
}

- (UITextField *)usernameTextField
{
    if (!_usernameTextField)
    {
        _usernameTextField = [[UITextField alloc] initForAutoLayout];
        _usernameTextField.delegate = self;
        _usernameTextField.backgroundColor = UIColorFromKey(@"white");
        _usernameTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
        _usernameTextField.layer.borderWidth = 2.0;
        _usernameTextField.layer.borderColor = [UIColorFromKey(@"white") colorWithAlphaComponent:0.1].CGColor;
        _usernameTextField.textAlignment = NSTextAlignmentCenter;
        _usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
    }
    
    return _usernameTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField)
    {
        _passwordTextField = [[UITextField alloc] initForAutoLayout];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.backgroundColor =  UIColorFromKey(@"white");
        _passwordTextField.delegate = self;
        _passwordTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
        _passwordTextField.layer.borderWidth = 2.0;
        _passwordTextField.layer.borderColor = [UIColorFromKey(@"white") colorWithAlphaComponent:0.1].CGColor;
        _passwordTextField.textAlignment = NSTextAlignmentCenter;
        _passwordTextField.placeholder = @"Password";
        _passwordTextField.returnKeyType = UIReturnKeyGo;
    }
    
    return _passwordTextField;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel)
    {
        _descriptionLabel = [[UILabel alloc] initForAutoLayout];
        _descriptionLabel.text = @"LOGIN USING";
        _descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0];
        _descriptionLabel.textColor = UIColorFromKey(@"white");
    }
    
    return _descriptionLabel;
}

- (AKPickerView *)servicePickerView
{
    if (!_servicePickerView)
    {
        _servicePickerView = [[AKPickerView alloc] initForAutoLayout];
        _servicePickerView.delegate = self;
        _servicePickerView.dataSource = self;
        _servicePickerView.pickerViewStyle = AKPickerViewStyleFlat;
        _servicePickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
        _servicePickerView.textColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        _servicePickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
        _servicePickerView.highlightedTextColor = UIColorFromKey(@"white");
        _servicePickerView.interitemSpacing = 30.0;
        _servicePickerView.maskDisabled = NO;
    }
    
    return _servicePickerView;
}

- (UIButton *)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.backgroundColor = UIColorFromKey(@"#c0392b");
        [_loginButton setTitleColor:UIColorFromKey(@"white") forState:UIControlStateNormal];
        [_loginButton setTitle:@"LOG IN" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
        [_loginButton addTarget:self action:@selector(loginButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _loginButton;
}

- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeButton setTitleColor:UIColorFromKey(@"white") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (NSMutableArray *)loginDetails
{
    if (!_loginDetails)
    {
        _loginDetails = [NSMutableArray array];
    }
    
    return _loginDetails;
}

- (NSArray *)loginServiceDetails
{
    return self.loginDetails.copy;
}

- (BOOL)isDismissable
{
    return !self.closeButton.hidden;
}

- (void)setDismissable:(BOOL)dismissable
{
    self.closeButton.hidden = !dismissable;
}

#pragma mark - Initializers

- (id)init
{
    return [self initWithClientManager:[AKClientManager sharedManager]];
}

- (id)initWithClientManager:(AKClientManager *)manager
{
    return [self initWithLoginSources:manager.loginSources];
}

- (id)initWithLoginSources:(NSArray *)loginSources
{
    //
    // Need at least a single login source to be able to initialize view controller correctly,
    // This is used incorrectly, so we trigger an exception.
    //
    
    if (!loginSources.count)
    {
        @throw [NSException exceptionWithName:@"com.unifiedsense.AuthKit" reason:@"AuthViewController requires at leat single login source." userInfo:nil];
    }
    
    self = [super init];
    
    if (self)
    {
        self.loginSources = loginSources.copy;
        
        self.view.backgroundColor = UIColorFromKey(@"#e74c3c");
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    // Construct views
    //
    
    [self.view addSubview:self.headerImageView];
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.servicePickerView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.closeButton];
    
    [self.view setNeedsUpdateConstraints];
    
    [self updateUIWithItem:0];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (self.didSetupConstraints)
    {
        return;
    }
    
    self.didSetupConstraints = YES;
    
    //
    // Username
    //
    
    [self.usernameTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:-60.0];
    [self.usernameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20.0];
    [self.usernameTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20.0];
    
    [self.usernameTextField autoSetDimension:ALDimensionHeight toSize:50.0];
    self.usernameTextField.layer.cornerRadius = 25.0;
    
    //
    // Password
    //
    
    [self.passwordTextField autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20.0];
    [self.passwordTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20.0];
    [self.passwordTextField autoSetDimension:ALDimensionHeight toSize:50.0];
    self.passwordTextField.layer.cornerRadius = 25.0;
    
    [self.passwordTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.usernameTextField withOffset:10.0];
    
    //
    // Description label
    //
    
    [self.descriptionLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    self.descriptionLabelConstraint = [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.passwordTextField withOffset:30.0];
    
    //
    // Picker view
    //
    
    [self.servicePickerView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20.0];
    [self.servicePickerView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20.0];
    [self.servicePickerView autoSetDimension:ALDimensionHeight toSize:50.0];
    [self.servicePickerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.descriptionLabel withOffset:10.0];
    
    //
    // Sign in button
    //
    
    [self.loginButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 20.0, 50.0, 20.0) excludingEdge:ALEdgeTop];
    
    [self.loginButton autoSetDimension:ALDimensionHeight toSize:50.0];
    self.loginButton.layer.cornerRadius = 25.0;
    
    //
    // Close button
    //
    
    [self.closeButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10.0];
    [self.closeButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    
    //
    // Header image view
    //
    
    [self.headerImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(100.0, 20.0, 0.0, 20.0) excludingEdge:ALEdgeBottom];
    [self.headerImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.usernameTextField withOffset:-70.0];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Actions

- (void)loginButtonTap:(UIButton *)sender
{
    id source = self.selectedLoginSource;
    
    //
    // Base checks for empty username, password, etc., but only in case we have a password source,
    // OAuth usually does this on it's own
    //
    
    if ([source respondsToSelector:@selector(loginWithUsername:password:success:failure:)])
    {
        NSString *errorMessage = nil;
        
        if (!self.usernameTextField.text.length)
        {
            self.usernameTextField.layer.borderColor = [UIColor alizarinColor].CGColor;
            
            errorMessage = errorMessage != nil ? errorMessage : NSLocalizedString(@"Enter username / email", @"");
        }
        else
        {
            self.usernameTextField.layer.borderColor = [UIColorFromKey(@"white") colorWithAlphaComponent:0.1].CGColor;
        }
        
        if (!self.passwordTextField.text.length)
        {
            self.passwordTextField.layer.borderColor = [UIColor alizarinColor].CGColor;
            
            errorMessage = errorMessage != nil ? errorMessage : NSLocalizedString(@"Enter password", @"");
        }
        else
        {
            self.passwordTextField.layer.borderColor = [UIColorFromKey(@"white") colorWithAlphaComponent:0.1].CGColor;
        }
        
        if (errorMessage.length)
        {
            self.descriptionLabel.text = [errorMessage uppercaseString];
            
            return;
        }
    }
    
    self.descriptionLabel.text = [NSLocalizedString(@"Logging in", @"") uppercaseString];
    
    AKSuccessBlock successBlock = ^(id details)
    {
        [self.loginDetails addObject:details];
        
        if ([self.delegate respondsToSelector:@selector(authViewController:authenticationSuccessForSource:userDetails:)])
        {
            [self.delegate authViewController:self authenticationSuccessForSource:source userDetails:details];
        }
        
        if (!self.allowsMultipleLogin && [self.delegate respondsToSelector:@selector(authViewControllerDidFinish:)])
        {
            [self.delegate authViewControllerDidFinish:self];
        }
    };
    
    AKFailureBlock failureBlock = ^(id responseObject, NSError *error)
    {
        self.descriptionLabel.text = [NSLocalizedString(@"Wrong username or password", @"") uppercaseString];
        
        if ([self.delegate respondsToSelector:@selector(authViewController:authenticationFailedForSource:error:)])
        {
            [self.delegate authViewController:self authenticationFailedForSource:source error:error];
        }
    };
    
    if ([source respondsToSelector:@selector(loginWithSuccess:failure:)])
    {
        [source loginWithSuccess:successBlock failure:failureBlock];
    }
    else if ([source respondsToSelector:@selector(loginWithUsername:password:success:failure:)])
    {
        [source loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text success:successBlock failure:failureBlock];
    }
}

- (void)closeButtonTap:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(authViewControllerDidFinish:)])
    {
        [self.delegate authViewControllerDidFinish:self];
    }
}

#pragma mark - AKPickerViewDelegate

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    return self.loginSources.count;
}

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    if (item < self.loginSources.count)
    {
        id<AKLoginSource> source = self.loginSources[item];
        
        return source.sourceName;
    }
    
    return @"";
}

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    if (self.loginSources.count == 0)
    {
        return;
    }
    
    [self updateUIWithItem:item];
    
    self.selectedLoginSource = self.loginSources[item];
}

#pragma mark - UITextFieldDelegate

#pragma mark - Helper functions

/*!
 *  Function animates UI to correct item
 *
 *  @param item index
 */
- (void)updateUIWithItem:(NSInteger)item
{
    BOOL reverse = NO;
    
    //
    // Check if it is reverse, in that case we must have currently an OAuth Login Source,
    // and next is the normal one.
    //
    
    id<AKLoginSource> source = self.loginSources[item];
    
    if ( (self.loginSources.count > 0) && (self.selectedLoginSource == nil) )
    {
        self.selectedLoginSource = self.loginSources[0];
    }
    else
    {
        reverse = ([self.selectedLoginSource conformsToProtocol:@protocol(AKOAuthLoginSource)] && ![source conformsToProtocol:@protocol(AKOAuthLoginSource)]);
        
    }
    
    //
    // If there is an AKOAuthLoginSource, hide username and password
    //
    
    BOOL isOAuthSource = [source conformsToProtocol:@protocol(AKOAuthLoginSource)];
    
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^
    {
        if (reverse)
        {
            self.descriptionLabelConstraint.constant = isOAuthSource ? -40.0 : 30.0;
            
            [self.view layoutIfNeeded];
        }
        else
        {
            self.usernameTextField.alpha = isOAuthSource ? 0.0 : 1.0;
            self.passwordTextField.alpha = isOAuthSource ? 0.0 : 1.0;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^
        {
            if (reverse)
            {
                self.usernameTextField.alpha = isOAuthSource ? 0.0 : 1.0;
                self.passwordTextField.alpha = isOAuthSource ? 0.0 : 1.0;
            }
            else
            {
                self.descriptionLabelConstraint.constant = isOAuthSource ? -40.0 : 30.0;
                
                [self.view layoutIfNeeded];
            }
        } completion:nil];
    }];
    
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    
    self.descriptionLabel.text = [NSLocalizedString(@"Login using", @"") uppercaseString];
    
    self.usernameTextField.placeholder = (source != nil) ? [NSString stringWithFormat:@"%@ User", source.sourceName] : @"User";
    
    if (self.allowsMultipleLogin)
    {
        [self.closeButton setTitle:@"Done" forState:UIControlStateNormal];
    }
    else
    {
        [self.closeButton setTitle:@"Cancel" forState:UIControlStateNormal];
    }
}

@end