//
//  OWTCell.h
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/22.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWTCell : UITableViewCell

@end

@interface OWTMessageCell : OWTCell

@end

@protocol OWTThanksCellDelegate;
@interface OWTThanksCell : OWTCell

@property (nonatomic, assign) id<OWTThanksCellDelegate> delegate;

@end

@protocol OWTThanksCellDelegate <NSObject>

- (void)owtThanksCell:(OWTThanksCell*)cell tappedThanksButton:(id)sender;

@end


@protocol OWTPostCellDelegate;
@interface OWTPostCell : OWTCell

@property (nonatomic, assign) id<OWTPostCellDelegate> delegate;

- (NSString*)postMessage;


@end

@protocol OWTPostCellDelegate <NSObject>

- (void)owtPostCell:(OWTPostCell*)cell didBeginEditing:(id)sender;
- (void)owtPostCell:(OWTPostCell*)cell didEndEditing:(id)sender;

- (void)owtPostCell:(OWTPostCell*)cell tappedSendButton:(id)sender;

@end