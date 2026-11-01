# Airbnb Marketplace Database

This project models the data behind an Airbnb-inspired accommodation marketplace using a relational MySQL database. It includes the schema, sample records, and SQL queries for exploring bookings, listing availability, revenue, reviews, and other marketplace activity.

## Project contents

| File | Description |
|---|---|
| `airbnb_schema.sql` | Creates the `airbnb_db` database and its tables, keys, and integrity constraints. |
| `airbnb_data.sql` | Loads sample records for the marketplace entities. |
| `test_queries.sql` | Provides example queries for reporting and analysis. |

## Database overview

The schema contains 20 related tables covering:

- **Marketplace setup:** `Country`, `ListingType`, `CancellationPolicy`, and `Amenity`
- **Users and properties:** `User`, `Listing`, `Room`, `ListingPhoto`, and `ListingAmenity`
- **Booking and discovery:** `Availability`, `Booking`, `Wishlist`, and `WishlistItem`
- **Communication and support:** `SocialConnection`, `Notification`, `Message`, and `Report`
- **Transactions and feedback:** `Payment`, `Payout`, and `Review`

Primary keys, foreign keys, unique constraints, enumerated statuses, and check constraints help maintain data integrity. The schema also represents relationships such as hosts publishing listings, guests making bookings, and users exchanging booking-related messages and reviews.

## Example SQL reports

`test_queries.sql` contains eight example queries:

1. Booking details with guest, listing, stay length, and status
2. Available listings for a selected date and guest capacity
3. Listing revenue, service fees, and host revenue
4. Host ratings and review counts
5. Estimated host earnings and payouts
6. Unread messages by user
7. Most wishlisted listings
8. Open reports and the users/listings involved

## Requirements

- MySQL 8.0 or a compatible MySQL database client
- A SQL client such as MySQL Workbench, or the MySQL command-line client

## Getting started

Run the scripts in this order:

1. **Create the database and tables** by running `airbnb_schema.sql`.
2. **Load the sample records** by running `airbnb_data.sql`.
3. **Explore the reports** by running `test_queries.sql`.

For the MySQL command-line client, from this folder:

```bash
mysql -u your_username -p < airbnb_schema.sql
mysql -u your_username -p airbnb_db < airbnb_data.sql
mysql -u your_username -p airbnb_db < test_queries.sql
```

Replace `your_username` with your MySQL account name. You will be prompted for the password. In MySQL Workbench, open and execute each script in the same order.

> **Warning:** `airbnb_schema.sql` begins by dropping the existing `airbnb_db` database before recreating it. Running the schema script again will delete the current database and its contents.

## Notes

- The included records are sample data intended for learning and query demonstration, not a live service or production dataset.
- Some example reports use fixed dates or particular booking statuses; adjust the filters in `test_queries.sql` to explore different results.
