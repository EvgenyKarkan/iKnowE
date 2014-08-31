//
//  EKAdditiveDescription.h
//  iKnowE
//
//  Created by Evgeny Karkan on 21.09.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


@interface EKAdditiveDescription : NSObject 

@property (nonatomic, strong) NSString *danger;
@property (nonatomic, strong) NSString *chemicalName;
@property (nonatomic, strong) NSString *code;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
