//
//  MHPhotoBrowserController.h
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import "MHPhotoBrowserController.h"
#import "MHPhotosBrowserView.h"
#import "MBProgressHUD+Extend.h"

@interface MHPhotoBrowserController ()<MHPhotosBrowseDelegate>
{
    MHPhotosBrowserView *photosBrowser;
}
@end

@implementation MHPhotoBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    photosBrowser = [[MHPhotosBrowserView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    photosBrowser.displayTopPageNumber = self.displayTopPage;
    photosBrowser.displayDeleteBtn= self.displayDeleteBtn;
    photosBrowser.currentImgIndex = self.currentImgIndex;
    [photosBrowser reloadPhotoBrowseWithPhotoArray:self.imgArray];
    [photosBrowser setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    photosBrowser.delegate = self;
    [self.view addSubview:photosBrowser];
}

- (void)photosBrowse:(MHPhotosBrowserView *)photosBrowse didClickDeleteBtnAtIndex:(NSInteger)index
{
    if (index < self.imgArray.count) {
        [self.imgArray removeObjectAtIndex:index];
        if (self.imgArray.count) {
            [photosBrowser reloadPhotoBrowseWithPhotoArray:self.imgArray];
        }
        else {
            [self singleTapDetected];
        }
    }
}

- (void)setDisplayTopPage:(BOOL)displayTopPage
{
    _displayTopPage = displayTopPage;
}

- (void)setDisplayDeleteBtn:(BOOL)displayDeleteBtn
{
    _displayDeleteBtn = displayDeleteBtn;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.imgArray.count == 0) {
        [MBProgressHUD showTextHUD:@"请设置图片"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)singleTapDetected
{
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    photosBrowser = nil;
}
@end
