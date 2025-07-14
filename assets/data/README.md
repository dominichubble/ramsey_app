# Ramsey App Data Documentation

This document explains the JSON data structure used in the Ramsey App and how to work with it.

## Overview

The `assets/data/app_data.json` file contains all the app's data in a structured JSON format. This includes:

- **Events**: Community events, festivals, workshops, etc.
- **News**: Local news articles and announcements
- **Restaurants**: Local dining establishments with menus and details
- **Categories**: Metadata for event types, news categories, etc.
- **App Metadata**: Version information and configuration

## Data Structure

### Events

Each event contains:
```json
{
  "id": "unique_identifier",
  "title": "Event Name",
  "description": "Event description",
  "date": "2025-07-12T11:00:00.000Z", // ISO 8601 format
  "imageUrl": "https://...", // Optional
  "location": "Event location",
  "type": "workshop|seminar|meeting|conference|webinar|consultation",
  "status": "upcoming|ongoing|completed|cancelled"
}
```

### News

Each news article contains:
```json
{
  "id": "unique_identifier",
  "title": "Article Title",
  "description": "Brief description",
  "content": "Full article content",
  "publishedDate": "2025-07-11T08:00:00.000Z",
  "imageUrl": "https://...", // Optional
  "author": "Author Name", // Optional
  "category": "realEstate|budgeting|investing|debt|business|insurance",
  "tags": ["tag1", "tag2"],
  "isFeatured": true|false,
  "readTimeMinutes": 5
}
```

### Restaurants

Each restaurant contains:
```json
{
  "id": "unique_identifier",
  "title": "Restaurant Name",
  "description": "Restaurant description",
  "location": "General area",
  "address": "Full address",
  "latitude": 54.3241,
  "longitude": -4.3834,
  "distance": 0.2,
  "likes": 187,
  "rating": 4.5,
  "totalReviews": 94,
  "foodImages": ["url1", "url2"],
  "coverImageUrl": "main_image_url",
  "cuisineType": "italian|chinese|mexican|indian|american|japanese|thai|french|mediterranean|korean|other",
  "priceRange": "budget|moderate|expensive|luxury",
  "phoneNumber": "+44 1624 813901",
  "email": "contact@restaurant.com",
  "website": "www.restaurant.com",
  "openingHours": {
    "Monday": "12:00 PM - 9:00 PM",
    // ... other days
  },
  "isOpen": true,
  "acceptsReservations": true,
  "hasDelivery": false,
  "hasTakeout": true,
  "hasWifi": true,
  "hasParking": true,
  "isWheelchairAccessible": true,
  "paymentMethods": ["Credit Card", "Cash", "Contactless"],
  "tags": ["traditional", "historic"],
  "menu": [
    {
      "id": "menu_item_id",
      "name": "Dish Name",
      "description": "Dish description",
      "price": 12.50,
      "category": "Starters|Mains|Desserts|Drinks",
      "imageUrl": "dish_image_url",
      "isVegetarian": false,
      "isVegan": false,
      "isGlutenFree": true,
      "isSpicy": false,
      "allergens": ["gluten", "dairy"]
    }
  ]
}
```

## Usage

### Using the DataService

The `DataService` class provides methods to load and parse the JSON data:

```dart
import 'package:ramsey_app/services/data_service.dart';

// Get all events
final dataService = DataService();
final events = await dataService.getEventsFromJson();

// Get all news
final news = await dataService.getNewsFromJson();

// Get all restaurants
final restaurants = await dataService.getRestaurantsFromJson();

// Get app metadata
final metadata = await dataService.getAppMetadata();
```

### Using the JsonEventService

For a more feature-rich event service that loads from JSON:

```dart
import 'package:ramsey_app/services/json_event_service.dart';

final eventService = JsonEventService();

// Get upcoming events
final upcomingEvents = await eventService.getUpcomingEvents();

// Get events for this week
final thisWeekEvents = await eventService.getThisWeekEvents();

// Search events
final searchResults = await eventService.searchEvents('festival');

// Refresh data from JSON
await eventService.refreshData();
```

## Integration with Existing Services

To integrate JSON data loading with existing services, you can:

1. **Replace existing services**: Use `JsonEventService` instead of `EventService`
2. **Hybrid approach**: Load initial data from JSON, then allow runtime modifications
3. **Fallback data**: Use JSON as fallback when API/network data is unavailable

### Example: Hybrid Event Service

```dart
class HybridEventService {
  final EventService _originalService = EventService();
  final JsonEventService _jsonService = JsonEventService();
  
  Future<List<Event>> getAllEvents() async {
    try {
      // Try to get events from original service first
      return _originalService.getAllEvents();
    } catch (e) {
      // Fallback to JSON data
      return await _jsonService.getAllEvents();
    }
  }
}
```

## Data Management

### Adding New Data

To add new events, news, or restaurants:

1. Edit `assets/data/app_data.json`
2. Add new entries to the appropriate array
3. Ensure unique IDs
4. Follow the data structure format
5. Run `flutter clean && flutter pub get` to refresh assets

### Data Validation

When adding new data, ensure:

- **Unique IDs**: No duplicate IDs within each data type
- **Valid dates**: Use ISO 8601 format (YYYY-MM-DDTHH:mm:ss.sssZ)
- **Valid enums**: Use only supported values for types, categories, etc.
- **Required fields**: Include all required fields for each data type
- **Image URLs**: Use accessible image URLs (preferably HTTPS)

### Performance Considerations

- JSON data is loaded once and cached in memory
- Use `refreshData()` methods to reload from JSON when needed
- For large datasets, consider pagination or lazy loading
- Consider implementing local storage/database for frequent updates

## Future Enhancements

Potential improvements to the data system:

1. **API Integration**: Replace JSON with REST API calls
2. **Offline Support**: Cache API data locally with JSON as fallback
3. **Real-time Updates**: WebSocket or push notifications for live data
4. **User-generated Content**: Allow users to submit events/reviews
5. **Data Synchronization**: Sync local changes with remote server
6. **Image Optimization**: Local image caching and compression

## Troubleshooting

### Common Issues

1. **Asset not found**: Ensure `assets/data/` is included in `pubspec.yaml`
2. **JSON parsing errors**: Validate JSON format using online validators
3. **Date parsing errors**: Ensure dates are in ISO 8601 format
4. **Missing required fields**: Check model requirements for each data type
5. **Image loading errors**: Verify image URLs are accessible

### Debug Tips

```dart
// Enable debug logging
try {
  final data = await dataService.getEventsFromJson();
} catch (e) {
  print('Error loading events: $e');
}

// Clear cache for testing
dataService.clearCache();
```
