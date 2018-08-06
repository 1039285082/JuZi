//
//  BWWStoreViewController.m
//  BigWhiteWallet
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BWWStoreViewController.h"
#import "BWWStoreCollectionViewCell.h"
#import "BWWeImageCollectionViewCell.h"
#import "CommodityModel.h"
#import "DetailsViewController.h"
#import "BWWStoreCollectionReusableView.h"
#import "EasyShowView.h"
#import <SDCycleScrollView.h>


@interface BWWStoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic)UICollectionView * collectionView;        //
@property (strong,nonatomic)UIButton * button1;        //
@property (strong,nonatomic)UIButton * button2;        //
@property (strong,nonatomic)UIButton * button3;        //
@property (strong,nonatomic)NSMutableArray * modelArr;        //模型数组


@end

@implementation BWWStoreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationItem.title=@"商城";
  
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [self.view addSubview:self.collectionView];
    UINib *nib1=[UINib nibWithNibName:@"BWWStoreCollectionViewCell" bundle:nil];
    UINib *nib2=[UINib nibWithNibName:@"BWWeImageCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib1 forCellWithReuseIdentifier:@"BWWStoreCollectionViewCell"];
    
    [self.collectionView registerNib:nib2 forCellWithReuseIdentifier:@"BWWeImageCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BWWStoreCollectionReusableView"];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collectionView代理方法
- ( UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    long index=indexPath.row;
    
        BWWStoreCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"BWWStoreCollectionViewCell" forIndexPath:indexPath];
        CommodityModel *model=_modelArr[index];

        NSString *imagePath=model.image;
        NSURL *url=[NSURL URLWithString:imagePath];
        [cell.imageView sd_setImageWithURL:url];
//
        
      
        
        cell.nameLabel.text=model.title;
//        NSLog(@"-------------%s",c);
        cell.totalPrice.text=[NSString stringWithFormat:@"总价:%@元",model.price_text];
        

        return cell;
    
   
   
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _modelArr.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([BWWSingleUser sharedSingleUser].user.isLogin==NO) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text=@"你还没有登录,请先登录";
        
        [hud hideAnimated:YES afterDelay:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CYloginRegisterViewController *loVC=[[CYloginRegisterViewController alloc]init];
            
            [self presentViewController:loVC animated:YES completion:nil];
        });
        
        
    }else{
        long index=indexPath.row;
        DetailsViewController *detailsVC=[[DetailsViewController alloc]init];
        detailsVC.model=[CommodityModel new];
        
        detailsVC.model=self.modelArr[index];
        //    self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detailsVC animated:YES];
        
        //    BWWStoreCollectionReusableView
    }

    
}
//collection头视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(KScreenWidth, KScreenHeight/3);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    BWWStoreCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BWWStoreCollectionReusableView" forIndexPath:indexPath];

    SDCycleScrollView*cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height-50) imageNamesGroup:@[@"b1.png",@"b2.png",@"b3.png"]];
    [headView addSubview:cycleScrollView];
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height-50, headView.frame.size.width, 50)];
    _button1=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, (KScreenWidth-40)/3, 50)];
    [_button1 setImage:[UIImage imageNamed:@"timg3.jpg"] forState:UIControlStateNormal];
    
    _button2=[[UIButton alloc]initWithFrame:CGRectMake(20+(KScreenWidth-40)/3, 0, (KScreenWidth-40)/3, 50)];
    [_button2 setImage:[UIImage imageNamed:@"timg2.jpg"] forState:UIControlStateNormal];
    
    _button3=[[UIButton alloc]initWithFrame:CGRectMake(20+((KScreenWidth-40)/3*2), 0, (KScreenWidth-40)/3, 50)];
    [_button3 setImage:[UIImage imageNamed:@"timg1.jpg"] forState:UIControlStateNormal];
    
    [_button1 addTarget:self action:@selector(didClickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(didClickBtn2) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(didClickBtn3) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, KScreenWidth, 1)];
    lable.backgroundColor=[UIColor lightGrayColor];
    
    [view addSubview:lable];
    
    [view addSubview:_button1];
    [view addSubview:_button2];
    [view addSubview:_button3];
    
    [headView addSubview:view];
    return headView;
}

#pragma mark - collection的flowlayout方法 设置cell大小和间距
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
        return CGSizeMake(KScreenWidth/2-1, 300);

  
}
//两行cell之间间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
         return 1;
    

}

//两个cell之间间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.modelArr=[NSMutableArray new];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"list1.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arr=dic[@"result"];
    for (int i=0; i<arr.count; i++) {
        CommodityModel *model=[CommodityModel mj_objectWithKeyValues:arr[i]];
        const char*c=[model.title cStringUsingEncoding:NSISOLatin1StringEncoding];
        model.title=[[NSString alloc]initWithCString:c encoding:NSUTF8StringEncoding];
        [_modelArr addObject:model];
    }
}
//点击button刷新collectionView
#pragma - mark点击刷新
-(void)didClickBtn1{
    self.modelArr=[NSMutableArray new];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"list1.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arr=dic[@"result"];
    for (int i=0; i<arr.count; i++) {
        CommodityModel *model=[CommodityModel mj_objectWithKeyValues:arr[i]];
        const char*c=[model.title cStringUsingEncoding:NSISOLatin1StringEncoding];
        model.title=[[NSString alloc]initWithCString:c encoding:NSUTF8StringEncoding];
        [_modelArr addObject:model];
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.bezelView.backgroundColor=[UIColor orangeColor];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil];
    [hud hideAnimated:YES afterDelay:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
}
-(void)didClickBtn2{
    self.modelArr=[NSMutableArray new];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"list2.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arr=dic[@"result"];
    for (int i=0; i<arr.count; i++) {
        CommodityModel *model=[CommodityModel mj_objectWithKeyValues:arr[i]];
        const char*c=[model.title cStringUsingEncoding:NSISOLatin1StringEncoding];
        model.title=[[NSString alloc]initWithCString:c encoding:NSUTF8StringEncoding];
        [_modelArr addObject:model];
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil];
    [hud hideAnimated:YES afterDelay:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}
-(void)didClickBtn3{
    self.modelArr=[NSMutableArray new];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"list3.json" ofType:nil];
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *arr=dic[@"result"];
    for (int i=0; i<arr.count; i++) {
        CommodityModel *model=[CommodityModel mj_objectWithKeyValues:arr[i]];
        const char*c=[model.title cStringUsingEncoding:NSISOLatin1StringEncoding];
        model.title=[[NSString alloc]initWithCString:c encoding:NSUTF8StringEncoding];
        [_modelArr addObject:model];
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.bezelView.backgroundColor=[UIColor orangeColor];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil];
    [hud hideAnimated:YES afterDelay:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


@end
