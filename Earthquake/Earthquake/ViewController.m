//
//  ViewController.m
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"
#import "Quake.h"
#import "QuakeWeb.h"
#import "Location.h"
#import "CustomCell.h"
#import "MapViewController.h"

#define kURLString  @"http://earthquake-report.com/feeds/recent-eq?json"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateButton;

//@property (nonatomic, copy) NSArray *quakeList;
@property (nonatomic, strong) NSManagedObjectContext *mainMoc; // will use to update the UI
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController; // pretty usefull for the table view population / and for collection view too

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainMoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.mainMoc setParentContext:self.globalMoc];
    
    self.tableView.estimatedRowHeight = 44; // any number is good
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil]forCellReuseIdentifier:@"com.kinja.customcell"];
    
    /*self.quakeList =*/ [self fetchData];
    //[self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSArray *) fetchData
- (void) fetchData
{
    /*NSEntityDescription *entity = [NSEntityDescription entityForName:@"Quake" inManagedObjectContext:self.mainMoc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"quakeMagnitude" ascending:NO];
    [fetchRequest setSortDescriptors:@[descriptor]];
    
    NSError *error;
    NSArray *quakes = [self.mainMoc executeFetchRequest:fetchRequest error:&error];
    
    if(nil != quakes ) {
        return quakes;
    }
    else {
        NSLog(@"%@ %@", error, error.localizedDescription);
        abort();
    }*/
    
    
    
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"%@ %@", error, error.localizedDescription);
        abort();
    }
    
    [self.tableView reloadData];
}

-(void) deleteData
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Quake" inManagedObjectContext:self.globalMoc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    
    NSError *error;
    NSArray *quakes = [self.globalMoc executeFetchRequest:fetchRequest error:&error];
    
    for(Quake *item in quakes) {
        [self.globalMoc deleteObject:item];
    }
    
    NSError *saveError;
    if(![self.globalMoc save:&saveError]){
        NSLog(@"%@ %@", saveError, saveError.localizedDescription);
        abort();
    }
}

- (IBAction)updateDate
{
    
    self.updateButton.enabled = NO;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:kURLString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    /* // By default we have a GET, if we want to upload, use POST
     NSMutableURLRequest
     mutable in case you want to do posts, stuff like this....
     urlRequest.HTTPMethod = @"POST";
     urlRequest setValue .....
     
     */
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(data.length > 0 && error == nil) { // we have data ..so everything is ok
            
            // PErform all on this block, to execute on the proper thread
            [self.globalMoc performBlock:^{
                
                
                NSError *jsonError;
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                NSLog(@"%@", json);
                
                if([json isKindOfClass:[NSArray class]])
                {
                    if(nil != json && [json count] > 0) {
                        
                        //delete what's in the DB
                        [self deleteData];
                        
                        // this not in the loop
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:sszzzz"];
                        
                        
                        for(NSDictionary *item in json){
                            NSString *title = item[@"title"];
                            NSString *magnitude = item[@"magnitude"];
                            NSString *depth = item[@"depth"];
                            NSString *location = item[@"location"];
                            NSString *latitude = item[@"latitude"];
                            NSString *longitude = item[@"longitude"];
                            NSString *dateTime = item[@"date_time"];
                            NSString *link = item[@"link"];
                            
                            Quake *quakeEntity = (Quake *)[NSEntityDescription insertNewObjectForEntityForName:@"Quake" inManagedObjectContext:self.globalMoc];
                            quakeEntity.quakeTitle = title;
                            quakeEntity.quakeLocation = location;
                            quakeEntity.quakeMagnitude = @([magnitude floatValue]);
                            quakeEntity.quakeDepth = @([depth floatValue]);
                            NSDate *date = [formatter dateFromString:dateTime];
                            quakeEntity.quakeDate = date;
                            
                            Location *quakeLocation = (Location *)[NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.globalMoc];
                            quakeLocation.quakeLatitute = @([latitude doubleValue]);
                            quakeLocation.quakeLongitude = @([longitude doubleValue]);
                            
                            QuakeWeb *quakeWeb = (QuakeWeb *)[NSEntityDescription insertNewObjectForEntityForName:@"QuakeWeb" inManagedObjectContext:self.globalMoc];
                            quakeWeb.quakeURL = link;
                            
                            // set the relationship
                            quakeEntity.location = quakeLocation;
                            quakeWeb.location = quakeLocation;
                            
                        }
                        
                        NSError *saveError;
                        if(![self.globalMoc save:&saveError]){
                            NSLog(@"%@ %@", saveError, saveError.localizedDescription);
                            abort();
                        }
                        
                        // wrap in the perform block (it send a message to the main MOC and does on the right queue, and all the piece of code will be executed on the same queue
                        [self.mainMoc performBlock:^{
                            /*self.quakeList = */[self fetchData];
                            // Update the UI On the main QUEUE
                            //[self.tableView reloadData];
                            self.updateButton.enabled = YES;
                        }];
                        
                        
                    }
                    
                }
                else if([json isKindOfClass:[NSDictionary class]])
                {
                    // for the example we know we get an array.. so we dont code here
                } else
                {
                    NSLog(@"Should not happen");
                }
                
                
            }];
            
        } else {
            if(error == nil) {
                switch ([(NSHTTPURLResponse *)response statusCode]) {
                    case 200: // OK
                        break;
                    case 400: // NOT OK
                        NSLog(@"BLABLA...");
                        break;
                    default:
                        break;
                }
            }
        }
        
    }];
    
    [dataTask resume]; // the connection only starts at this point. not before!!
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 1;
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.quakeList.count;
    if([[self.fetchedResultsController sections] count] > 0) {
        id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else {
        return 0;
    }
    
    //return [[self.fetchedResultsController ]]
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"com.kinja.customcell" forIndexPath:indexPath];
    
    //Quake *quake = self.quakeList[indexPath.row];
    Quake *quake = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.labelTitle.text = quake.quakeTitle;
    cell.labelLocation.text = quake.quakeLocation;
    cell.labelMagnitude.text =  [NSString stringWithFormat:@"Mag: %@", [quake.quakeMagnitude stringValue]];
    cell.labelDepth.text = [NSString stringWithFormat:@"Dep: %@", [quake.quakeDepth stringValue]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    cell.labelDate.text = [formatter stringFromDate:quake.quakeDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Quake *quake = (Quake *)self.quakeList[indexPath.row];
    Quake *quake = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    Location *location = quake.location;
    MapViewController *viewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    viewController.location = location;
    [self showViewController:viewController sender:nil];
}

- (NSFetchedResultsController *) fetchedResultsController
{
    if(_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = self.mainMoc;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Quake" inManagedObjectContext:context];
    fetchRequest.entity = entity;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"quakeMagnitude" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"com.kinja.frc"];
    
    self.fetchedResultsController = controller;
    return  controller;
}

@end
