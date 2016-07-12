//
//  UserInfoViewController.m
//  NewWealthPublicOpinion
//
//  Created by XAYQ-FanXL on 16/6/23.
//  Copyright © 2016年 XAYQ-FanXL. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UICommon.h"
#import "UserInfoModel.h"
#import "UserInfoTableViewCell.h"
#import "UserInfoTableHeadView.h"
#import "UserHeader.h"
#import "MBProgressHUD+Extend.h"
#import "HttpManager.h"
#import "HelpManager.h"
#import "ModifyNamePhoneViewController.h"
#import "ModifyPasswordViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserInfoViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserInfoTableHeadView *headView;

@end

static NSString *userInfoCell = @"userInfoCell";

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [UICommon setNavBarTitle:self.navigationItem title:@"用户信息"];
    self.dataSource = [UserInfoModel getUserInfoSource];
    [self createSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataSource = [UserInfoModel getUserInfoSource];
    [self.tableView reloadData];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

- (void)createSubview {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UserInfoTableViewCell class] forCellReuseIdentifier:userInfoCell];
    self.tableView.rowHeight = 44;
    
    self.headView = [[UserInfoTableHeadView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 120)];
    NSString *iconImage = [UserHandler sharedUserHandler].loginUser.photo;
    if (iconImage != nil || [iconImage isEqualToString:@""]) {
        [self.headView.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconImage] placeholderImage:[UIImage imageNamed:@"example"]];
    }
    self.tableView.tableHeaderView = self.headView;
    //点击headview头像
    [self.headView headClickedBlock:^(UIButton *button) {
        if (![HelpManager isVisitor]) {
            [self createActionSheet];
        }
    }];
}

- (void)createActionSheet {
    if (kiOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf openPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
        UIAlertAction *fromeCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf openPhoto:UIImagePickerControllerSourceTypeCamera];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:fromPhotoAction];
        [alertController addAction:fromeCameraAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选取", @"拍照", nil];
        [sheet showInView:self.view];
    }
    
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self openPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 1:
            [self openPhoto:UIImagePickerControllerSourceTypeCamera];
            break;
        default:
            break;
    }
}

//打开相册  相机
- (void)openPhoto:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:userInfoCell forIndexPath:indexPath];
    UserInfoModel *userInfo = self.dataSource[indexPath.row];
    infoCell.titleLabel.text = userInfo.title;
    infoCell.valueLabel.text = userInfo.value;
    return infoCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([HelpManager isVisitor]) {
        return;
    }
    UIViewController *pushVC;
    switch (indexPath.row) {
        case 0:
            pushVC = [[ModifyNamePhoneViewController alloc] initWithModifyType:ModifyName];
            break;
        case 1:
            pushVC = [[ModifyNamePhoneViewController alloc] initWithModifyType:ModifyPhone];
            break;
        case 2:
            pushVC = [[ModifyPasswordViewController alloc] init];
            break;
        default:
            pushVC = [[ModifyNamePhoneViewController alloc] initWithModifyType:ModifyName];
            break;
    }
    [self.navigationController pushViewController:pushVC animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *headImgData = UIImageJPEGRepresentation(image, 0.9);
    self.headView.iconImageView.image = image;
    [MBProgressHUD showMessage:@"正在上传头像..."];
    [HttpManager uploadUserHeadPhoto:headImgData SuccessBlock:^(NSDictionary *returnData) {
        if ([returnData[kStatus] intValue] == kSuccess) {
            [MBProgressHUD showSuccess:@"上传头像成功"];
            NSString *headImage = [returnData objectForKey:@"message"];
            if ( headImage != nil && ![headImage isEqualToString:@""] )
            {
                [UserHandler sharedUserHandler].loginUser.photo = headImage;
                [UserManager saveUserInfo:[UserHandler sharedUserHandler].loginUser];
            }
        } else {
            [MBProgressHUD showError:@"上传头像失败"];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD showError:@"上传头像失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
