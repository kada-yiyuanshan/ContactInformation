//
//  ContactInformationViewController.m
//  ContactInformation
//
//  Created by apple  on 12-10-30.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "ContactInformationViewController.h"
#import "ContentBean.h"
#import "CommentXMLParse.h"
#import "HelpDataBase.h"
#import "DataBaseBean.h"
#import "AddViewController.h"

@interface ContactInformationViewController ()


@end   

@implementation ContactInformationViewController

@synthesize listdata;
@synthesize indexlist;
@synthesize mysearchBar;
@synthesize filteredListContent;
@synthesize data;
@synthesize keys;
@synthesize names;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"Student";
    }
    return self;
}
-(void)dealloc
{
    [data release];
    [filteredListContent release];
    [mysearchBar release];
    [indexlist release];
    [databasebean release];
    [helpdatabase release];
    [listdata release];
    [super dealloc];
}


- (void)viewDidLoad
{
   data = [[NSMutableArray alloc] init];
    
    [self.tableView reloadData];
  
    [self setTabBarButton];
    [self.listdata removeAllObjects];
    helpdatabase = [[HelpDataBase alloc] init];
    databasebean = [[DataBaseBean alloc] init];
    self.listdata = [[NSMutableArray alloc] init];
    [self readdata];
    [self setmysearchBar];
    
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listdata count]];
    [self.tableView reloadData];
    
    NSDictionary *namearrayindict = [NSDictionary dictionaryWithObject:listdata forKey:@"Names"];
    self.names=namearrayindict;
   
    //NSArray *arry=[[names objectForKey:@"Names"] sortedArrayUsingSelector:@selector(compare:)];
    [self.data addObject:names];
    [self addxmldatatotable];
   
   // self.keys=arry;
    [super viewDidLoad];
}

-(void)setmysearchBar
{
    self.tableView.tableHeaderView  = self.mysearchBar;
    self.mysearchBar.showsCancelButton = NO;

}

-(void)addxmldatatotable
{
    
    NSError *_error = [[NSError alloc] init];
    NSString *filename = [[NSBundle mainBundle] pathForResource:@"people_list" ofType:@"xml"];
    NSString *_content = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&_error];
    NSMutableArray *xmllistdata = [[NSMutableArray alloc] init];
    [CommentXMLParse parseArrXML:_content commentArr:xmllistdata ];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        for (NSInteger i=0; i<[xmllistdata count]; i++)
    {
        databasebean =[xmllistdata objectAtIndex:i];
        [helpdatabase insertTotable:databasebean];
    }
      }
  
    [xmllistdata release];
    [_error release];


}

-(void)readdata
{
    [self.listdata removeAllObjects];
    [helpdatabase queryTotable:self.listdata];
}

-(void)setTabBarButton
{
    self.navigationItem.leftBarButtonItem =self.editButtonItem;
    UIBarButtonItem *rightbutton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addclick:)];
    self.navigationItem.rightBarButtonItem=rightbutton;
    [rightbutton release];
 
}
-(IBAction)addclick:(id)sender
{
    AddViewController *addController = [[AddViewController alloc] initWithNibName:@"AddViewController" bundle:nil] ;
    addController.b_Edit = NO;
    [self.navigationController  pushViewController:addController animated:YES];
    [addController release];
    

}

- (void)viewDidUnload
{
    listdata=nil;
    helpdatabase=nil;
    databasebean=nil;
    self.filteredListContent = nil;
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.mysearchBar resignFirstResponder];
    [self readdata];
    //sorting
    NSSortDescriptor* sortByA = [NSSortDescriptor sortDescriptorWithKey:@"firstname" ascending:YES];
    [listdata sortUsingDescriptors:[NSArray arrayWithObject:sortByA]];

    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma make -Table View index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *searcharray = [[NSArray alloc] initWithObjects:
                            @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",
                            @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X",@"Y" ,@"Z",nil];
    return searcharray;
}
#pragma make -Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        
        return 1;
        
    }
	else
	{
        return [data count];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
        
    }
	else
	{
        NSDictionary *dictionary = [data objectAtIndex:section];
		NSArray *array = [dictionary objectForKey:@"Names"];
		return [array count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	
	if(tableView == self.searchDisplayController.searchResultsTableView)
		return -1;
	
	return index % 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        databasebean = [filteredListContent objectAtIndex:indexPath.row];
        cell.textLabel.text = databasebean.firstname;
        cell.detailTextLabel.text = databasebean.lastname;

    }
	else
	{
        NSDictionary *dictionary = [data objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"Names"];
        databasebean = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = databasebean.firstname;
        cell.detailTextLabel.text = databasebean.lastname;
  
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        databasebean= [listdata objectAtIndex:indexPath.row];
        //delete data from sqlite
        [helpdatabase deleteTotable:databasebean];
        //delete data from array
        [listdata removeObjectAtIndex:indexPath.row];
        //delete data from tableview
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddViewController *addview =[[[AddViewController alloc] initWithNibName:@"AddViewController" bundle:nil] autorelease];
   
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
         NSInteger indexrow = indexPath.row;
  
         NSDate *object = [filteredListContent objectAtIndex:indexrow];
         addview.detailItem = object;
    }else
    {
        NSDictionary *dictionary = [data objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"Names"];
         NSDate *object = [array objectAtIndex:indexPath.row];
         addview.detailItem = object;
         
    }
    addview.b_Edit = YES;
    [self.navigationController pushViewController:addview animated:YES];
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText 
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	self.mysearchBar.showsCancelButton = YES;
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (databasebean in listdata)
	{
		
        NSComparisonResult result = [databasebean.firstname compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
			{
				[self.filteredListContent addObject:databasebean];
            }
		
	}
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
     
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
   
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

// called when Search (in our case "Done") button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}


@end
