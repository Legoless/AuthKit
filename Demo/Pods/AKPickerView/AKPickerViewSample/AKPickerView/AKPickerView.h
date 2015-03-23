//
//  AKPickerView.h
//  AKPickerViewSample
//
//  Created by Akio Yasui on 3/29/14.
//  Copyright (c) 2014 Akio Yasui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKPickerView;

@protocol AKPickerViewDelegate <NSObject>
@required
- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView;
- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item;
@optional
- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item;
@end

@interface AKPickerView : UIView

@property (nonatomic, weak) id <AKPickerViewDelegate> delegate;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *highlightedFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) CGFloat fisheyeFactor; // 0...1; slight value recommended such as 0.0001
@property (nonatomic, assign, readonly) NSUInteger selectedItem;

- (void)reloadData;
- (void)scrollToItem:(NSUInteger)item animated:(BOOL)animated;
- (void)selectItem:(NSUInteger)item animated:(BOOL)animated;

@end
