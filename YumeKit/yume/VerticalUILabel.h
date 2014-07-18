//
//  VerticalUILabel.h
//  test
//
//  Created by Yume on 2014/5/28.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticalUILabel : UILabel{
    
@private
    VerticalAlignment _verticalAlignment;
    
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
