//
//  PXBottomSheetTextView.h
//  PXBottomSheetTextView
//
//  Created by user on 10/06/18.
//

#import <Foundation/Foundation.h>

#import <CNPPopupController/CNPPopupController.h>

@interface PXBottomSheetTextView : NSObject

@property (nonatomic, strong) NSString *title;
@property int titleSize;
@property (nonatomic, strong) NSString *titleColor;

@property (nonatomic, strong) NSString *desc;
@property int descriptionSize;
@property (nonatomic, strong) NSString *descriptionColor;

@property (nonatomic, strong) CNPPopupController *popupController;

- (void)show;

@end
