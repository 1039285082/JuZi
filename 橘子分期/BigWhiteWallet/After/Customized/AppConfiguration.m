//
//  Configuration.m
//  MeiDai-OC
//
//  Created by WuShan on 17/2/11.
//  Copyright © 2017年 Maideed. All rights reserved.
//

#import "AppConfiguration.h"
#import "SessionData.h"

@implementation AppConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        self.rawJsonString = @"{}";
        self.dict = [[NSMutableDictionary alloc] init];
        self.dict[@"news_mode"] = @"1";
    }
    return self;
}

- (instancetype)init: (NSString*)json
{
    self = [super init];
    if (self) {
        self.rawJsonString = json;
        self.dict = (NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:[self.rawJsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    }
    return self;
}

- (instancetype)initWithDict: (NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.dict = dict;
    }
    return self;
}

-(int) version{
    if(self.dict != nil && [self.dict objectForKey:@"version"] != nil) {
        return (int)[self.dict objectForKey:@"version"];
    }
    return -1;
}

-(NSString*)assetUrl{
    if(self.dict != nil && [self.dict objectForKey:@"asset_url"] != nil) {
        return (NSString*)[self.dict objectForKey:@"asset_url"];
    }
    return nil;
}

-(bool)isNewsMode{
    if([[SessionData getInstance] isDeviceInUS]) {
        return true;
    }
    if(self.dict != nil && [self.dict objectForKey:@"news_mode"]!= nil) {
        return [self.dict[@"news_mode"] boolValue];
    }
    return true;
}

-(NSString*) hunt_promotedWebUrl{
    if(self.dict != nil && [self.dict objectForKey:@"promote_url"]!= nil) {
        return (NSString*)[self.dict objectForKey:@"promote_url"];
    }
    return nil;
}

-(NSString*)hunt_tabNameAtIndex:(int)index{
    if(self.dict != nil && [self.dict objectForKey:@"tabs"]!= nil) {
        NSDictionary* tabs = (NSDictionary*)[self.dict objectForKey:@"tabs"];
        if(index < tabs.count) {
            return (NSString*)[(NSDictionary*)[tabs objectForKey:[NSString stringWithFormat: @"%d",index]] objectForKey:@"name"];
        }
    }
    return nil;
}

-(NSString*) hunt_tabTitleAtIndex:(int)index{
    if(self.dict != nil && [self.dict objectForKey:@"tabs"]!= nil) {
        NSDictionary *tabs = (NSDictionary*)[self.dict objectForKey:@"tabs"];
        if(index < tabs.count){
            return (NSString*)[(NSDictionary*)[tabs objectForKey: [NSString stringWithFormat:@"%d", index]] objectForKey:@"navigation_bar_title"];
        }
    }
    return nil;
}

-(NSString*) hunt_tabImageAtIndex:(int)index{
    if(self.dict != nil && [self.dict objectForKey:@"tabs"]!= nil) {
        NSDictionary *tabs = (NSDictionary*)[self.dict objectForKey:@"tabs"];
        if(index < tabs.count){
            return (NSString*)[(NSDictionary*)[tabs objectForKey: [NSString stringWithFormat:@"%d", index]] objectForKey:@"image"];
        }
    }
    return nil;
}

-(NSString*) hunt_tabUrlAtIndex:(int)index {
    if(self.dict != nil && [self.dict objectForKey:@"tabs"]!= nil) {
        NSDictionary *tabs = (NSDictionary*)[self.dict objectForKey:@"tabs"];
        if(index < tabs.count){
            return (NSString*)[(NSDictionary*)[tabs objectForKey: [NSString stringWithFormat:@"%d", index]] objectForKey:@"web_url"];
        }
    }
    return nil;
}


-(NSMutableArray*) hunt_bannerImageNamesOnHome{
    if(self.dict != nil && [self.dict objectForKey:@"home_banner_images"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"home_banner_images"];
        if(imagesInfo.count > 0) {
            NSMutableArray* images = [[NSMutableArray alloc] init];
            for(int i=0;i<imagesInfo.count;i++) {
                NSString* imagePath = (NSString*)[(NSDictionary*)(imagesInfo[i]) objectForKey:@"image"];
                [images addObject:imagePath];
            }
            return images;
        }
    }
    return [[NSMutableArray alloc] initWithObjects:@"banner1.png",@"banner2.png", @"banner3.png", nil];
}

-(NSString*)hunt_bannerImageTargetOnHome:(int)index{
    if(self.dict != nil && [self.dict objectForKey:@"home_banner_images"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"home_banner_images"];
        if(imagesInfo.count > 0 && index < imagesInfo.count) {
            return (NSString*)[(NSDictionary*)(imagesInfo[index]) objectForKey:@"target"];
        }
    }
    return nil;
}

-(NSMutableArray*)hunt_menuImagesNameOnHome{
    if([self version] == 0 ){
        return [[NSMutableArray alloc] initWithObjects:@"menu-news", @"menu-calc", @"menu-calc2", @"menu-bible"];
    }
    if(self.dict != nil && [self.dict objectForKey:@"home_menu"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"home_menu"];
        if(imagesInfo.count > 0) {
            NSMutableArray* images = [[NSMutableArray alloc] init];
            for(int i=0; i<imagesInfo.count;i++) {
                NSString* imagePath = (NSString*)[(NSDictionary*)(imagesInfo[i]) objectForKey:@"image"];
                [images addObject:imagePath];
            }
            return images;
        }
    }
    return [[NSMutableArray alloc] initWithObjects:@"menu-news", @"menu-calc", @"menu-calc2", @"menu-bible"];
}

-(NSMutableArray*) hunt_aboutImagesNames{
    if([self version] == 0 ){
        return [[NSMutableArray alloc] initWithObjects:@"Info.png", @"Knowledge.png", @"Math.png", @"Student.png"];
    }
    if(self.dict != nil && [self.dict objectForKey:@"about"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"about"];
        if(imagesInfo.count > 0) {
            NSMutableArray* images = [[NSMutableArray alloc] init];
            for(int i=0; i<imagesInfo.count;i++) {
                NSString* imagePath = (NSString*)[(NSDictionary*)(imagesInfo[i]) objectForKey:@"image"];
                [images addObject:imagePath];
            }
            return images;
        }
    }
    return [[NSMutableArray alloc] initWithObjects:@"Info.png", @"Knowledge.png", @"Math.png", @"Student.png"];
}

-(int) hunt_aboutColumnCount{
    if(self.dict != nil && [self.dict objectForKey:@"about_column_count"]!= nil) {
        return (int)[self.dict objectForKey:@"about_column_count"];
    }
    return 2;
}

-(NSMutableArray*)hunt_aboutTitles{
    if(self.dict != nil && [self.dict objectForKey:@"about"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"about"];
        if(imagesInfo.count > 0) {
            NSMutableArray* images = [[NSMutableArray alloc] init];
            for(int i=0; i<imagesInfo.count;i++) {
                NSString* imagePath = (NSString*)[(NSDictionary*)(imagesInfo[i]) objectForKey:@"title"];
                [images addObject:imagePath];
            }
            return images;
        }
    }
    return [[NSMutableArray alloc] init];
}


-(NSString*) hunt_aboutBannerImageName{
    if(self.dict != nil && [self.dict objectForKey:@"about_banner_image"]!= nil) {
        NSString* imgName = (NSString*)[self.dict objectForKey:@"about_banner_image"];
        return imgName;
    }
    return @"banner1.png";
}

-(NSMutableArray*) hunt_aboutNavigationTitles{
    if(self.dict != nil && [self.dict objectForKey:@"about"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"about"];
        if(imagesInfo.count > 0) {
            NSMutableArray* images = [[NSMutableArray alloc] init];
            for(int i=0; i<imagesInfo.count;i++) {
                NSString* imagePath = (NSString*)[(NSDictionary*)(imagesInfo[i]) objectForKey:@"navigation_bar_title"];
                [images addObject:imagePath];
            }
            return images;
        }
    }
    
    return [[NSMutableArray alloc] init];
}

-(NSMutableArray*) hunt_menuTitlesOnHome{
    if(self.dict != nil && [self.dict objectForKey:@"home_menu"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"home_menu"];
        if(imagesInfo.count > 0) {
            NSMutableArray* titles = [[NSMutableArray alloc] init];
            for(int i=0;i<imagesInfo.count;i++) {
                NSString* titl = (NSString*)[(NSDictionary*)(imagesInfo[i]) objectForKey:@"title"];
                [titles addObject:titl];
            }
            return titles;
        }
    }
    return [[NSMutableArray alloc] init];
}

-(NSMutableArray*) hunt_menuTargetsOnHome{
    if(self.dict != nil && [self.dict objectForKey:@"home_menu"]!= nil) {
        NSArray* imagesInfo = (NSArray*)[self.dict objectForKey:@"home_menu"];
        if(imagesInfo.count > 0) {
            NSMutableArray* titles = [[NSMutableArray alloc] init];
            for(int i=0;i<imagesInfo.count;i++) {
                NSString* titl = (NSString*)[(NSDictionary*)(imagesInfo[i]) objectForKey:@"target_url"];
                if(![[titl stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]  isEqual: @""]) {
                    [titles addObject:titl];
                }
                else {
                    int target_tab = (int)([(NSDictionary*)(imagesInfo[i]) objectForKey:@"target_tab"]);
                    if(target_tab != -1) {
                        [titles addObject:[NSString stringWithFormat:@"tab://%d", target_tab]];
                    }
                }
            }
            return titles;
        }
    }
    return [[NSMutableArray alloc] init];
}

@end
