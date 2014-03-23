//
//  OWTCell.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/22.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTCell.h"

@implementation OWTCell

@end

@implementation OWTThanksCell

- (IBAction)tappedThanksCell:(id)sender {
    [self.delegate owtThanksCell:self
              tappedThanksButton:sender];
}

@end


@interface OWTPostCell()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation OWTPostCell

- (void)awakeFromNib
{
    [self.messageTextView setBorderColor:[UIColor lightGrayColor] borderWidth:1.0f cornerRadius:5.0f];
}
- (NSString*)postMessage
{
    return self.messageTextView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.delegate owtPostCell:self didBeginEditing:textView];
    self.placeholderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.delegate owtPostCell:self didEndEditing:textView];
    self.placeholderLabel.hidden = textView.text.length != 0;
}

- (IBAction)tappedSendButton:(id)sender {
    if (self.messageTextView.text.length == 0) {
        return;
    }
    
    [self.delegate owtPostCell:self tappedSendButton:sender];
}



@end