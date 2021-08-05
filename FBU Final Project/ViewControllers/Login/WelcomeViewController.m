//
//  LoginViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/12/21.
//

#import "WelcomeViewController.h"
#import "EnterPhoneNumberViewController.h"
#import "DesignHelper.h"
#import "BasicButton.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
    [self startEmitter];
}

- (void)setUpUI{
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    BasicButton* continueWithPhoneNumberButton = [[BasicButton alloc]init];
    continueWithPhoneNumberButton.translatesAutoresizingMaskIntoConstraints = NO;
    [continueWithPhoneNumberButton setTitle:@"Continue With Phone" forState:UIControlStateNormal];
    continueWithPhoneNumberButton.backgroundColor = [DesignHelper buttonBackgroundColor];
    [continueWithPhoneNumberButton setTitleColor:[DesignHelper buttonTitleLabelColor] forState:UIControlStateNormal];
    
    [self.view addSubview:continueWithPhoneNumberButton];
    
    [NSLayoutConstraint activateConstraints:@[
            [continueWithPhoneNumberButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
            [continueWithPhoneNumberButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16],
            [continueWithPhoneNumberButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-32],
            [continueWithPhoneNumberButton.heightAnchor constraintEqualToConstant:50]
    ]];
    
    [continueWithPhoneNumberButton addTarget:self action:@selector(continueWithPhoneNumberButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont systemFontOfSize:50 weight:UIFontWeightHeavy];
    titleLabel.text = @"Cornerstore";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:titleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16.0],
        [titleLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16.0],
        [titleLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

- (void)continueWithPhoneNumberButtonPressed{
    EnterPhoneNumberViewController *vc = [[EnterPhoneNumberViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK:- Some fun stuff...CAEmitterLayer
-(void)startEmitter{
    UIView *emitterView = [[UIView alloc] init];
    CAEmitterLayer *emitterLayer = [[CAEmitterLayer alloc] init];
    
    emitterLayer.emitterPosition = CGPointMake(self.view.frame.size.width/2, -40);
    emitterLayer.emitterSize = CGSizeMake(self.view.frame.size.width, 1);
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    emitterLayer.emitterCells = [self getEmitterCells];
    //emitterLayer.birthRate = 0.125;
    
    [emitterView.layer addSublayer:emitterLayer];
    emitterView.backgroundColor = UIColor.clearColor;
    emitterView.alpha = 0.7;
    [self.view addSubview:emitterView];
    [self.view sendSubviewToBack:emitterView];
    
    [NSLayoutConstraint activateConstraints:@[
        [emitterView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [emitterView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [emitterView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [emitterView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
    ]];
    emitterView.translatesAutoresizingMaskIntoConstraints = false;
}

/*Gets emitter cells
 - Emoji Id is the corresponding emoji in Assets
 
 */
- (NSMutableArray<CAEmitterCell *> *) getEmitterCells{
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++){
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];;
        cell.birthRate = 0.5;
        cell.lifetime = 20;
        cell.velocity = arc4random_uniform(50) + 50;
        cell.scale = 0.1;
        cell.scaleRange = 0.005;
        cell.emissionRange = M_PI/4;
        cell.emissionLatitude = (180 * (M_PI / 180));
        cell.alphaRange = 0.3;
        cell.yAcceleration = arc4random_uniform(10) + 10;

        NSString *emojiId = @"emoji";
        cell.contents = (id) [[UIImage imageNamed:emojiId] CGImage];
        [cells addObject:cell];
    }
    
    return cells;
}



@end
