//
//  ViewController.m
//  Table
//
//  Created by Alexandre THOMAS on 31/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *tempList = [[NSMutableArray alloc] initWithCapacity:100];
    for(int i=0; i<100; i++) {
        [tempList addObject:@(i)];
    }
    
    self.dataList = tempList; // same to self.dataList = [tempList copy]
    
    // if we have autolayout,
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"com.kinja.cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"com.kinja.cell"];
    
    [self addAddButton];
    [self addEditButton];
}

- (void) addAddButton
{
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add -1" style:UIBarButtonItemStylePlain target:self action:@selector(addEntryInTheList)];
    self.navigationItem.leftBarButtonItem = addButton;
}

- (IBAction) addEntryInTheList
{
    NSMutableArray *tmpArray = [self.dataList mutableCopy];
    [tmpArray insertObject:@(-1) atIndex:0];
    self.dataList = tmpArray;
    
    // Request table view to reload
    [self.tableView reloadData];

}

- (void) addEditButton
{
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(startEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *tmpArray = [self.dataList mutableCopy];
    [tmpArray removeObjectAtIndex:indexPath.row];
    self.dataList = tmpArray;
    
    // Request table view to reload
    [self.tableView reloadData]; // deleteRownatIndexPath
    
    //[self.tableView deleteSections:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void) addDoneButton
{
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(stopEditMode)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (IBAction)startEditMode
{
    [self.tableView setEditing:YES animated:YES];
    [self addDoneButton];
}

- (IBAction)stopEditMode
{
    
    [self.tableView setEditing:NO animated:YES];
    [self addEditButton];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *tmpArray = [self.dataList mutableCopy];
    
    NSNumber *numberToMove = tmpArray[sourceIndexPath.row];
    [tmpArray removeObjectAtIndex:sourceIndexPath.row];
    [tmpArray insertObject:numberToMove atIndex:destinationIndexPath.row];

    self.dataList = tmpArray;
    
    // Request table view to reload
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.kinja.cell" forIndexPath:indexPath];
    //cell.textLabel.text = [self.dataList[indexPath.row] stringValue];
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.kinja.cell" forIndexPath:indexPath];
    cell.landscapeLabel.text = [self.dataList[indexPath.row] stringValue];
    
    UIImage *image = [UIImage imageNamed:@"papatiti"];
    cell.landscapeImageView.image = image ;
    
    return cell;
}


@end
