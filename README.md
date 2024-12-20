# Installation

Run migrations and seeds. It's very important to run the seeds because they will create an api_token used for API authentication.

# Added Files

#### `app/controllers/cars_controller.rb`
This is the controller serving as the API endpoint to query car results.

#### `app/serializers/brand_serializer.rb` and `app/serializers/car_serializer.rb`
These files format each car for the final response.

Response Format:
```
{
  "id": <car id>,
  "brand": {
    "id": <car brand id>,
    "name": <car brand name>
  },
  "price": <car price>,
  "rank_score": <rank score>,
  "model": <car model>,
  "label": <"perfect_match"|"good_match"|null>
}
```
#### `app/services/http_client.rb`
This service is used to make all kinds of requests using the Faraday gem.

#### `app/services/car_match_labeler.rb`
A service responsible for assigning the label to a car based on specific conditions.

#### `app/services/car_recommendation_service.rb`
This service handles requests to the external recommendation service, which provides the cars' rank scores.

#### `app/services/cars_filter_service.rb`
This service encapsulates most of the functionality:

1. Filters the results by brand (query param).
2. Filters cars by price range (price_min - price_max).
3. Assigns labels (perfect_match, good_match, or null) and scores from the third-party API.
4. Sort results

# Results

To make a request to the endpoint, you need an API Token (generated by running the seeds) since it uses bearer token authentication. You can use tools like Postman, HTTPie, Insomnia, etc.

### Request URL:
http://localhost:3000/cars

Permitted Params:
```
{
  "user_id": <user id (required)>,
  "query": <car brand name or part of car brand name to filter by (optional)>,
  "price_min": <minimum price (optional)>,
  "price_max": <maximum price (optional)>,
  "page": <page number for pagination (optional, default 1, default page size is 20)>
}
```
### Example Response:
```
{
    "cars": [
        {
            "id": 179,
            "brand": {
                "id": 39,
                "name": "Volkswagen"
            },
            "model": "Derby",
            "price": 37230,
            "rank_score": 0.945,
            "label": "perfect_match"
        },
        {
            "id": 5,
            "brand": {
                "id": 2,
                "name": "Alfa Romeo"
            },
            "model": "Arna",
            "price": 39938,
            "rank_score": 0.4552,
            "label": "perfect_match"
        },
        {
            "id": 180,
            "brand": {
                "id": 39,
                "name": "Volkswagen"
            },
            "model": "e-Golf",
            "price": 35131,
            "rank_score": null,
            "label": "perfect_match"
        },
        {
            "id": 181,
            "brand": {
                "id": 39,
                "name": "Volkswagen"
            },
            "model": "Amarok",
            "price": 31743,
            "rank_score": null,
            "label": "good_match"
        },
        {
            "id": 186,
            "brand": {
                "id": 2,
                "name": "Alfa Romeo"
            },
            "model": "Brera",
            "price": 40938,
            "rank_score": null,
            "label": "good_match"
        },
        {
            "id": 97,
            "brand": {
                "id": 20,
                "name": "Lexus"
            },
            "model": "IS 220",
            "price": 39858,
            "rank_score": 0.9489,
            "label": "null"
        },
        {
            "id": 36,
            "brand": {
                "id": 6,
                "name": "Buick"
            },
            "model": "GL 8",
            "price": 86657,
            "rank_score": 0.7068,
            "label": "null"
        },
        {
            "id": 13,
            "brand": {
                "id": 3,
                "name": "Audi"
            },
            "model": "90",
            "price": 56959,
            "rank_score": 0.567,
            "label": "null"
        },
        {
            "id": 103,
            "brand": {
                "id": 22,
                "name": "Lotus"
            },
            "model": "Eclat",
            "price": 48953,
            "rank_score": 0.4729,
            "label": "null"
        },
        {
            "id": 177,
            "brand": {
                "id": 38,
                "name": "Toyota"
            },
            "model": "Allion",
            "price": 40687,
            "rank_score": 0.1657,
            "label": "null"
        },
        {
            "id": 32,
            "brand": {
                "id": 6,
                "name": "Buick"
            },
            "model": "Verano",
            "price": 21739,
            "rank_score": 0.0967,
            "label": "null"
        },
        {
            "id": 176,
            "brand": {
                "id": 37,
                "name": "Suzuki"
            },
            "model": "Kizashi",
            "price": 40181,
            "rank_score": 0.0353,
            "label": "null"
        },
        {
            "id": 113,
            "brand": {
                "id": 24,
                "name": "Mazda"
            },
            "model": "3",
            "price": 1542,
            "rank_score": null,
            "label": "null"
        },
        {
            "id": 100,
            "brand": {
                "id": 20,
                "name": "Lexus"
            },
            "model": "RX 300",
            "price": 1972,
            "rank_score": null,
            "label": "null"
        },
        {
            "id": 184,
            "brand": {
                "id": 40,
                "name": "Volvo"
            },
            "model": "610",
            "price": 3560,
            "rank_score": null,
            "label": "null"
        },
        {
            "id": 142,
            "brand": {
                "id": 31,
                "name": "Ram"
            },
            "model": "Promaster City",
            "price": 3687,
            "rank_score": null,
            "label": "null"
        },
        {
            "id": 120,
            "brand": {
                "id": 26,
                "name": "Mercury"
            },
            "model": "Marauder",
            "price": 3990,
            "rank_score": null,
            "label": "null"
        },
        {
            "id": 109,
            "brand": {
                "id": 23,
                "name": "Maserati"
            },
            "model": "Levante",
            "price": 4243,
            "rank_score": null,
            "label": "null"
        },
        {
            "id": 89,
            "brand": {
                "id": 16,
                "name": "Infiniti"
            },
            "model": "M25",
            "price": 4372,
            "rank_score": null,
            "label": "null"
        },
        {
            "id": 164,
            "brand": {
                "id": 35,
                "name": "Smart"
            },
            "model": "Forfour",
            "price": 4391,
            "rank_score": null,
            "label": "null"
        }
    ],
    "meta": {
        "current_page": 1,
        "next_page": 2,
        "prev_page": null,
        "total_pages": 10,
        "total_count": 186
    }
}
```
