- [x] A Feed of items for sale
- [x] Upload items for sale with image
- [x] Login flow
- [x] User persistance
- [x] Multiple ViewControllers
- [x] Each item has a price

**Optional Nice-to-have Stories**

- [x] Custom camera UI
- [x] Tinder-like animation
- [x] UIViewcontroller transiiton animations
- [ ] Full text search
- [x] Using ML to identify what the object is
- [x] Custom Snapchat-like TabbarController 
- [x] Customise UI
- [x] Ability to add items to cart
- [x] Shopping cart page
- [x] Ability to post item from camera roll
- [x] Progress HUD
- [x] Buttons to assist with left/right swipe
- [x] Checkout button with total order's price

### 2. Screen Archetypes

* FeedViewController
   * Has the "for you" page
   * Tinder like swiping
* CameraViewController
   * A custom camera viewcontroller
* CreateListingViewController
    * A form page to create the item lisitng
* ExploreViewController
    * An explore page to see 
* WelcomeViewController
    * Viewcontroller that begins the login flow
* ItemDetailsViewController
    * Details Viewcontroller for an item listing

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* FeedViewController
* CameraViewController
* ExploreViewControlelr

**Flow Navigation** (Screen to Screen)

* FeedViewController
   * ItemDetailViewController
* CameraViewController
   * CreateListingViewController
* ExploreViewController
    * ItemDetailViewController

## Wireframes
![](https://i.imgur.com/begKuL9.jpg)

## Schema 
* Users
    * Firebase Collection of users
* Lisitings
    * Firebase Collections of Item listings
### Models
* FirebaesObject
    * An abstract class meant for storing helper functions with Firebase
* User
    * User class- also has a singleton reference to current user. This class inherits from FirebaseObject
* Listing
    * Item listing- inherits from FirabaseObject
### Networking
