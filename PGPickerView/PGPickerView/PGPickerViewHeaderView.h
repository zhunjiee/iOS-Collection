//
//  PGPickerViewHeaderView.h
//  PGPickerView
//
//  Created by zl on 2019/6/1.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^handlerBlock)(void);

@interface PGPickerViewHeaderView : UIView
@property (nonatomic, copy)  handlerBlock cancelButtonHandlerBlock;
@property (nonatomic, copy)  handlerBlock confirmButtonHandlerBlock;

// 头部标题
@property (nonatomic, copy) NSString *titleLabelText;

@end

NS_ASSUME_NONNULL_END
