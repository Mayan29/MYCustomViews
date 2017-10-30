//
//  ViewController.m
//  IM客户端
//
//  Created by mayan on 2017/10/25.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYClientManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, MYClientManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) NSMutableArray *messages;

@property (nonatomic, strong) MYClientManager *clientManager;

@end

@implementation ViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _clientManager = [MYClientManager shareManager];
    [_clientManager connectToHost:@"10.11.111.1" onPort:6001 currentUserId:100];
    _clientManager.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changKeyboardFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.messages[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }
}


#pragma mark - Action
- (IBAction)sendButtonClick
{
    [_clientManager sendMessage:_textField.text];
    NSString *message = [NSString stringWithFormat:@"我：%@", _textField.text];
    [self.messages addObject:message];
    [self.tableView reloadData];
    
    _textField.text = @"";
    [_textField resignFirstResponder];
}


#pragma mark - NSNotification
- (void)changKeyboardFrame:(NSNotification *)notification
{
    CGFloat beginY = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin.y;
    CGFloat endY = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, endY - beginY);
}


#pragma mark - MYClientManagerDelegate
- (void)clientManager:(MYClientManager *)manager didReadMsg:(NSString *)msg userId:(long)userId
{
    // 用 userId 来判断是谁发的消息，这里统一用 别人
    NSString *message = [NSString stringWithFormat:@"别人：%@", msg];
   
    [self.messages addObject:message];
    [self.tableView reloadData];
}


#pragma mark - Lazy load
- (NSMutableArray *)messages
{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}


@end
