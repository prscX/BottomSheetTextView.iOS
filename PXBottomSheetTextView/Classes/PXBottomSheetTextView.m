//
//  PXBottomSheetTextView.m
//  PXBottomSheetTextView
//
//  Created by user on 10/06/18.
//

#import "PXBottomSheetTextView.h"

@implementation PXBottomSheetTextView

- (void)show {
    UIColor *titleClr;
    if (self.titleColor != nil) {
        titleClr = [PXBottomSheetTextView ColorFromHexCode: self.titleColor];
    } else {
        titleClr = [PXBottomSheetTextView ColorFromHexCode: @"#000000"];
    }

    UIColor *descriptionClr = [PXBottomSheetTextView ColorFromHexCode: self.descriptionColor];
    if (self.descriptionColor != nil) {
        descriptionClr = [PXBottomSheetTextView ColorFromHexCode: self.descriptionColor];
    } else {
        descriptionClr = [PXBottomSheetTextView ColorFromHexCode: @"#757575"];
    }

    if (self.titleSize == 0) {
        self.titleSize = 25;
    }
    if (self.descriptionSize == 0) {
        self.descriptionSize = 20;
    }

    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSAttributedString *titleStyle = [[NSAttributedString alloc] initWithString:self.title attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:self.titleSize], NSParagraphStyleAttributeName: paragraphStyle}];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = titleStyle;
    titleLabel.textColor = titleClr;
    
    NSAttributedString *descriptionStyle = [[NSAttributedString alloc] initWithString:self.desc attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.descriptionSize], NSParagraphStyleAttributeName: paragraphStyle}];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height / 2)];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:scrollView];
    
    UILabel *scrollViewLabel = [[UILabel alloc] init];
    scrollViewLabel.attributedText = descriptionStyle;
    scrollViewLabel.translatesAutoresizingMaskIntoConstraints = NO;
    scrollViewLabel.numberOfLines = 0;
    scrollViewLabel.textColor = descriptionClr;
    
    [scrollView addSubview:scrollViewLabel];
    
    /*** Auto Layout ***/
    
    NSDictionary *views = NSDictionaryOfVariableBindings(scrollView, scrollViewLabel);
    
    NSArray *scrollViewLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollViewLabel(scrollView)]" options:0 metrics:nil views:views];
    [scrollView addConstraints:scrollViewLabelConstraints];
    
    scrollViewLabelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollViewLabel]|" options:0 metrics:nil views:views];
    [scrollView addConstraints:scrollViewLabelConstraints];
    //
    NSArray *scrollViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[scrollView]-|" options:0 metrics:nil views:views];
    [view addConstraints:scrollViewConstraints];
    
    scrollViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[scrollView]-|" options:0 metrics:nil views:views];
    [view addConstraints:scrollViewConstraints];
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, view]];

    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
    self.popupController.theme.maxPopupWidth = [UIScreen mainScreen].bounds.size.width - 20;
    self.popupController.delegate = self;

    [self.popupController presentPopupControllerAnimated: YES];
}


+ (UIColor *) ColorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
