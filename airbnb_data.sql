-- =============================================================================
-- Airbnb Data
-- =============================================================================

INSERT INTO Country (country_name, country_code, currency_code, currency_symbol) VALUES
('United States',   'US', 'USD', '$'),
('United Kingdom',  'GB', 'GBP', '£'),
('Germany',         'DE', 'EUR', '€'),
('France',          'FR', 'EUR', '€'),
('Spain',           'ES', 'EUR', '€'),
('Italy',           'IT', 'EUR', '€'),
('Netherlands',     'NL', 'EUR', '€'),
('Australia',       'AU', 'AUD', 'A$'),
('Canada',          'CA', 'CAD', 'C$'),
('Japan',           'JP', 'JPY', '¥'),
('Brazil',          'BR', 'BRL', 'R$'),
('Mexico',          'MX', 'MXN', 'MX$'),
('Portugal',        'PT', 'EUR', '€'),
('Greece',          'GR', 'EUR', '€'),
('Thailand',        'TH', 'THB', '฿'),
('South Africa',    'ZA', 'ZAR', 'R'),
('Argentina',       'AR', 'ARS', '$'),
('New Zealand',     'NZ', 'NZD', 'NZ$'),
('Sweden',          'SE', 'SEK', 'kr'),
('Norway',          'NO', 'NOK', 'kr');

-- -----------------------------------------------------------------------------
-- ListingType (3 rows)
-- -----------------------------------------------------------------------------
INSERT INTO ListingType (type_name, description) VALUES
('Entire Place',  'Guests have the whole property — no shared spaces with the host.'),
('Private Room',  'Guests have their own bedroom but may share common areas.'),
('Shared Room',   'Guests sleep in a shared space such as a dormitory room.');

-- -----------------------------------------------------------------------------
-- CancellationPolicy (3 rows)
-- -----------------------------------------------------------------------------
INSERT INTO CancellationPolicy (policy_name, description, refund_percentage, days_before_checkin) VALUES
('Flexible',  'Full refund if cancelled at least 24 hours before check-in.',                                                                              100.00, 1),
('Moderate',  'Full refund if cancelled at least 5 days before check-in; 50% refund after that.',                                                         50.00,  5),
('Strict',    '50% refund if cancelled at least 7 days before check-in. No refund if cancelled within 7 days of check-in.',                               0.00,   7);

-- -----------------------------------------------------------------------------
-- Amenity (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO Amenity (amenity_name, amenity_category) VALUES
('WiFi',                  'Facilities'),
('Air Conditioning',      'Comfort'),
('Heating',               'Comfort'),
('Kitchen',               'Facilities'),
('Washing Machine',       'Facilities'),
('Free Parking',          'Facilities'),
('Swimming Pool',         'Facilities'),
('Hot Tub',               'Facilities'),
('Gym',                   'Facilities'),
('TV',                    'Comfort'),
('Smoke Alarm',           'Safety'),
('Carbon Monoxide Alarm', 'Safety'),
('First Aid Kit',         'Safety'),
('Fire Extinguisher',     'Safety'),
('Pets Allowed',          'Policy'),
('Breakfast Included',    'Facilities'),
('Dedicated Workspace',   'Comfort'),
('BBQ Grill',             'Facilities'),
('EV Charger',            'Facilities'),
('Baby Crib',             'Comfort');

-- -----------------------------------------------------------------------------
-- User (20 rows — Guests, Hosts, one Admin)
-- IDs assigned by AUTO_INCREMENT: 1=Alice(Guest), 2=Bob(Host), 3=Clara(Guest),
-- 4=David(Host), 5=Emma(Guest), 6=Faris(Host), 7=Grace(Guest), 8=Henry(Host),
-- 9=Isabelle(Guest), 10=James(Host), 11=Karen(Guest), 12=Luca(Host),
-- 13=Mia(Guest), 14=Nathan(Guest), 15=Olivia(Host), 16=Pedro(Host),
-- 17=Quinn(Guest), 18=Rachel(Guest), 19=Samuel(Host), 20=Admin
-- -----------------------------------------------------------------------------
INSERT INTO User (first_name, last_name, email, password_hash, phone_number, profile_picture, bio, role, date_joined, is_verified) VALUES
('Alice',    'Johnson',   'alice@email.com',    'hash_alice_001',    '+14155550101',  'https://cdn.airbnb.com/users/1.jpg',  'Love travelling and exploring local cultures.',        'Guest', '2022-03-10 09:00:00', TRUE),
('Bob',      'Williams',  'bob@email.com',      'hash_bob_002',      '+14155550102',  'https://cdn.airbnb.com/users/2.jpg',  'Passionate host with properties across Europe.',       'Host',  '2021-06-15 10:30:00', TRUE),
('Clara',    'Martinez',  'clara@email.com',    'hash_clara_003',    '+34911000111',  'https://cdn.airbnb.com/users/3.jpg',  'Solo traveller and food lover.',                       'Guest', '2023-01-05 14:00:00', TRUE),
('David',    'Brown',     'david@email.com',    'hash_david_004',    '+447700900001', 'https://cdn.airbnb.com/users/4.jpg',  'Superhost with a cosy cottage in the Cotswolds.',      'Host',  '2020-11-20 08:00:00', TRUE),
('Emma',     'Wilson',    'emma@email.com',     'hash_emma_005',     '+491711234567', 'https://cdn.airbnb.com/users/5.jpg',  'Tech worker who travels every quarter.',               'Guest', '2022-09-01 11:00:00', TRUE),
('Faris',    'Ahmed',     'faris@email.com',    'hash_faris_006',    '+971501234567', 'https://cdn.airbnb.com/users/6.jpg',  'Host of a modern flat in Berlin city centre.',         'Host',  '2021-03-18 09:45:00', TRUE),
('Grace',    'Kim',       'grace@email.com',    'hash_grace_007',    '+821012345678', 'https://cdn.airbnb.com/users/7.jpg',  'Backpacker and adventure seeker.',                     'Guest', '2023-04-22 16:00:00', FALSE),
('Henry',    'Lopez',     'henry@email.com',    'hash_henry_008',    '+34612000222',  'https://cdn.airbnb.com/users/8.jpg',  'Owns a beachfront villa in Barcelona.',                'Host',  '2019-08-05 07:30:00', TRUE),
('Isabelle', 'Dupont',    'isabelle@email.com', 'hash_isabelle_009', '+33612000333',  'https://cdn.airbnb.com/users/9.jpg',  'Lover of art and boutique accommodation.',             'Guest', '2022-12-01 13:00:00', TRUE),
('James',    'Chen',      'james@email.com',    'hash_james_010',    '+61412000444',  'https://cdn.airbnb.com/users/10.jpg', 'Australian host with a harbour-view apartment.',       'Host',  '2020-05-10 10:00:00', TRUE),
('Karen',    'Nguyen',    'karen@email.com',    'hash_karen_011',    '+14255550111',  'https://cdn.airbnb.com/users/11.jpg', 'Digital nomad working remotely across Asia.',          'Guest', '2023-07-14 08:30:00', TRUE),
('Luca',     'Ferrari',   'luca@email.com',     'hash_luca_012',     '+393401234567', 'https://cdn.airbnb.com/users/12.jpg', 'Host of a Tuscan farmhouse with pool and vineyard.',   'Host',  '2018-09-25 11:00:00', TRUE),
('Mia',      'Schmidt',   'mia@email.com',      'hash_mia_013',      '+491721234568', 'https://cdn.airbnb.com/users/13.jpg', 'First-time traveller exploring Europe.',               'Guest', '2024-01-10 15:30:00', FALSE),
('Nathan',   'Patel',     'nathan@email.com',   'hash_nathan_014',   '+447700900002', 'https://cdn.airbnb.com/users/14.jpg', 'Remote worker seeking short-term lets.',               'Guest', '2023-02-28 12:00:00', TRUE),
('Olivia',   'Johansson', 'olivia@email.com',   'hash_olivia_015',   '+46701234567',  'https://cdn.airbnb.com/users/15.jpg', 'Superhost in Stockholm with 150+ five-star reviews.',  'Host',  '2019-04-14 09:00:00', TRUE),
('Pedro',    'Alves',     'pedro@email.com',    'hash_pedro_016',    '+351912000555', 'https://cdn.airbnb.com/users/16.jpg', 'Host of a sea-view apartment in Lisbon.',              'Host',  '2021-10-30 08:00:00', TRUE),
('Quinn',    'Okafor',    'quinn@email.com',    'hash_quinn_017',    '+2347012345678','https://cdn.airbnb.com/users/17.jpg', 'Frequent business traveller.',                         'Guest', '2022-06-20 14:00:00', TRUE),
('Rachel',   'Taylor',    'rachel@email.com',   'hash_rachel_018',   '+14355550188',  'https://cdn.airbnb.com/users/18.jpg', 'Enjoys weekend getaways and hiking trips.',            'Guest', '2023-08-15 10:00:00', TRUE),
('Samuel',   'Andersen',  'samuel@email.com',   'hash_samuel_019',   '+4712345678',   'https://cdn.airbnb.com/users/19.jpg', 'Owns a cabin in the Norwegian fjords.',                'Host',  '2020-02-14 07:00:00', TRUE),
('Admin',    'System',    'admin@airbnb.com',   'hash_admin_020',    '+18005551234',  NULL,                                  'Platform administrator account.',                      'Admin', '2018-01-01 00:00:00', TRUE);

-- -----------------------------------------------------------------------------
-- Listing (20 rows)
-- Host user IDs: Bob=2, David=4, Faris=6, Henry=8, James=10,
--                Luca=12, Olivia=15, Pedro=16, Samuel=19
-- listing_type_id: 1=Entire Place, 2=Private Room, 3=Shared Room
-- country_id: 2=UK, 3=Germany, 4=France, 5=Spain, 6=Italy,
--             8=Australia, 9=Canada, 13=Portugal, 19=Sweden, 20=Norway
-- cancellation_policy_id: 1=Flexible, 2=Moderate, 3=Strict
-- -----------------------------------------------------------------------------
INSERT INTO Listing (host_id, listing_type_id, country_id, cancellation_policy_id, title, description, address, city, latitude, longitude, price_per_night, cleaning_fee, min_stay_nights, max_guests, is_active) VALUES
(2,  1, 2,  1, 'Charming London Flat in Shoreditch',         'A stylish two-bedroom flat in the heart of Shoreditch, steps from great restaurants and the Overground.',              '14 Brick Lane',          'London',           51.523300,  -0.072700, 120.00, 25.00, 2,  4,  TRUE),
(2,  2, 3,  2, 'Private Room in Berlin Mitte',               'A bright private room in a shared flat in central Berlin. Perfect for solo travellers or couples.',                    'Unter den Linden 22',    'Berlin',           52.516300,  13.377700, 55.00,  10.00, 1,  2,  TRUE),
(4,  1, 2,  3, 'Cotswold Stone Cottage',                     'A quintessential English stone cottage surrounded by rolling hills. Log fire, garden, and complete privacy.',          '3 Mill Lane',            'Bourton',          51.874200,  -1.755600, 200.00, 40.00, 3,  6,  TRUE),
(6,  1, 3,  1, 'Modern Apartment near Brandenburg Gate',     'Sleek and fully equipped apartment with panoramic city views, 5 minutes walk from the Brandenburg Gate.',             'Pariser Platz 4',        'Berlin',           52.516800,  13.378200, 95.00,  20.00, 1,  3,  TRUE),
(8,  1, 5,  2, 'Beachfront Villa in Barcelona',              'Stunning villa with private pool and direct beach access. Sleeps 10. Perfect for groups and families.',               'Passeig Maritim 88',     'Barcelona',        41.385100,   2.194700, 450.00, 80.00, 5,  10, TRUE),
(10, 1, 8,  1, 'Harbour View Apartment — Sydney',            'Wake up to views of the Sydney Harbour Bridge from this beautiful one-bedroom apartment in Milsons Point.',            '6 Blues Point Road',     'Sydney',          -33.846500, 151.208700, 180.00, 35.00, 2,  2,  TRUE),
(12, 1, 6,  3, 'Tuscan Farmhouse with Vineyard',             'Authentic stone farmhouse surrounded by vineyards and olive groves. Private pool, wine cellar, and stunning sunsets.', 'Via Chiantigiana 101',   'Greve in Chianti', 43.585200,  11.315800, 320.00, 60.00, 4,  8,  TRUE),
(15, 2, 19, 1, 'Private Room in Stockholm Sodermalm',        'Cosy private room in a classic Swedish apartment. Excellent transport links to the city centre.',                      'Hornsgatan 55',          'Stockholm',        59.316400,  18.056300, 70.00,  12.00, 1,  2,  TRUE),
(16, 1, 13, 2, 'Lisbon Sea-View Apartment in Alfama',        'Bright one-bedroom apartment with sweeping Atlantic views in the historic Alfama district.',                           'Rua das Portas do Sol 8','Lisbon',           38.712800,  -9.133600, 110.00, 20.00, 2,  3,  TRUE),
(19, 1, 20, 1, 'Norwegian Fjord Cabin',                      'Remote off-grid cabin with breathtaking fjord views. Wood-burning stove, hiking trails, and total tranquillity.',     'Naeroyfjord Road 1',     'Gudvangen',        60.878700,   6.832900, 175.00, 50.00, 2,  4,  TRUE),
(2,  1, 4,  1, 'Elegant Parisian Studio near the Louvre',    'A beautifully decorated studio apartment in the 1st arrondissement, walking distance from the Louvre.',               'Rue de Rivoli 210',      'Paris',            48.860200,   2.342000, 130.00, 20.00, 1,  2,  TRUE),
(4,  2, 2,  2, 'Private Room in Covent Garden',              'Lovely private room in a Georgian townhouse right in the heart of Covent Garden. All amenities included.',            '7 Long Acre',            'London',           51.512800,  -0.123600, 85.00,  15.00, 1,  2,  TRUE),
(6,  3, 3,  1, 'Shared Dorm in Berlin Kreuzberg',            'Budget-friendly shared dorm in the vibrant Kreuzberg neighbourhood. Great for solo travellers on a budget.',          'Oranienstrasse 14',      'Berlin',           52.499500,  13.421200, 30.00,  5.00,  1,  6,  TRUE),
(8,  1, 5,  3, 'City Centre Penthouse in Madrid',            'Luxury penthouse with rooftop terrace and panoramic Madrid skyline views. Minutes from the Prado Museum.',             'Gran Via 50',            'Madrid',           40.419900,  -3.702800, 280.00, 50.00, 3,  4,  TRUE),
(10, 2, 8,  1, 'Private Room in Melbourne CBD',              'Clean and comfortable private room in a shared apartment right in the Melbourne CBD. Great transport links.',          '22 Collins Street',      'Melbourne',       -37.813900, 144.963200, 65.00,  10.00, 1,  2,  TRUE),
(12, 1, 6,  2, 'Luxury Amalfi Coast Villa',                  'Perched on the cliffs above Positano, this six-bedroom villa has a private pool and unmatched sea views.',            'Via Positanesi 5',       'Positano',         40.628100,  14.484400, 750.00,120.00, 5,  12, TRUE),
(15, 1, 19, 1, 'Waterfront Apartment in Stockholm Gamla Stan','A tasteful apartment in the Old Town of Stockholm, surrounded by medieval architecture and cobblestone streets.',    'Stortoget 1',            'Stockholm',        59.325600,  18.071400, 140.00, 25.00, 2,  4,  TRUE),
(16, 2, 13, 1, 'Private Room near Belem Tower — Lisbon',     'Light-filled private room in a traditional tile-fronted house, a short walk from the famous Belem Tower.',            'Rua de Belem 45',        'Lisbon',           38.697200,  -9.206800, 60.00,  10.00, 1,  2,  TRUE),
(19, 1, 20, 2, 'Aurora Borealis Retreat — Northern Norway',  'Glass-ceiling cabin designed for northern lights viewing. Heated, fully equipped kitchen, sleeps four.',              'Senja Island Road 5',    'Senja',            69.323100,  17.520400, 350.00, 75.00, 3,  4,  TRUE),
(2,  1, 9,  1, 'Downtown Toronto Condo with Lake Views',     'Modern high-rise condo with stunning Lake Ontario views. Walking distance to the CN Tower and Distillery District.',   'Lake Shore Blvd E 1',    'Toronto',          43.638900, -79.381200, 155.00, 30.00, 2,  3,  TRUE);

-- -----------------------------------------------------------------------------
-- Room (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO Room (listing_id, room_name, room_type, num_beds) VALUES
(1,  'Main Bedroom',         'Bedroom',     1),
(1,  'Second Bedroom',       'Bedroom',     2),
(1,  'Living Room',          'Living Room', 0),
(2,  'Private Room',         'Bedroom',     1),
(3,  'Master Bedroom',       'Bedroom',     1),
(3,  'Twin Room',            'Bedroom',     2),
(3,  'Lounge',               'Living Room', 0),
(4,  'Double Bedroom',       'Bedroom',     1),
(5,  'Master Suite',         'Bedroom',     1),
(5,  'Guest Room 1',         'Bedroom',     2),
(5,  'Guest Room 2',         'Bedroom',     2),
(5,  'Guest Room 3',         'Bedroom',     2),
(6,  'Bedroom',              'Bedroom',     1),
(7,  'Master Bedroom',       'Bedroom',     1),
(7,  'Guest Bedroom',        'Bedroom',     2),
(9,  'Sea View Bedroom',     'Bedroom',     1),
(10, 'Cabin Bedroom',        'Bedroom',     2),
(11, 'Studio Sleeping Area', 'Bedroom',     1),
(14, 'Master Suite',         'Bedroom',     1),
(19, 'Glass Roof Bedroom',   'Bedroom',     2);

-- -----------------------------------------------------------------------------
-- ListingPhoto (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO ListingPhoto (listing_id, photo_url, caption, is_cover, uploaded_at) VALUES
(1,  'https://cdn.airbnb.com/listings/1/cover.jpg',  'Living area with natural light',        TRUE,  '2022-04-01 10:00:00'),
(1,  'https://cdn.airbnb.com/listings/1/room1.jpg',  'Master bedroom',                        FALSE, '2022-04-01 10:05:00'),
(2,  'https://cdn.airbnb.com/listings/2/cover.jpg',  'Private room with desk',                TRUE,  '2021-07-01 09:00:00'),
(3,  'https://cdn.airbnb.com/listings/3/cover.jpg',  'Stone cottage exterior',                TRUE,  '2020-12-01 08:00:00'),
(3,  'https://cdn.airbnb.com/listings/3/garden.jpg', 'Beautiful English garden',              FALSE, '2020-12-01 08:10:00'),
(4,  'https://cdn.airbnb.com/listings/4/cover.jpg',  'Open plan living with city views',      TRUE,  '2021-04-01 11:00:00'),
(5,  'https://cdn.airbnb.com/listings/5/cover.jpg',  'Villa from the beach',                  TRUE,  '2019-09-01 07:00:00'),
(5,  'https://cdn.airbnb.com/listings/5/pool.jpg',   'Private pool at sunset',                FALSE, '2019-09-01 07:15:00'),
(6,  'https://cdn.airbnb.com/listings/6/cover.jpg',  'Harbour Bridge view from balcony',      TRUE,  '2020-06-01 09:00:00'),
(7,  'https://cdn.airbnb.com/listings/7/cover.jpg',  'Farmhouse entrance and vineyard',       TRUE,  '2018-10-01 08:00:00'),
(7,  'https://cdn.airbnb.com/listings/7/pool.jpg',   'Pool with Chianti hills backdrop',      FALSE, '2018-10-01 08:30:00'),
(8,  'https://cdn.airbnb.com/listings/8/cover.jpg',  'Bright private room',                   TRUE,  '2019-05-01 10:00:00'),
(9,  'https://cdn.airbnb.com/listings/9/cover.jpg',  'Atlantic views from the terrace',       TRUE,  '2021-11-01 09:00:00'),
(10, 'https://cdn.airbnb.com/listings/10/cover.jpg', 'Fjord panorama from cabin deck',        TRUE,  '2020-03-01 07:00:00'),
(10, 'https://cdn.airbnb.com/listings/10/fire.jpg',  'Cosy interior with log fire',           FALSE, '2020-03-01 07:30:00'),
(11, 'https://cdn.airbnb.com/listings/11/cover.jpg', 'Studio with Eiffel Tower peek',         TRUE,  '2022-02-01 10:00:00'),
(14, 'https://cdn.airbnb.com/listings/14/cover.jpg', 'Rooftop terrace at night',              TRUE,  '2021-02-01 08:00:00'),
(16, 'https://cdn.airbnb.com/listings/16/cover.jpg', 'Amalfi coast panorama',                 TRUE,  '2018-05-01 09:00:00'),
(19, 'https://cdn.airbnb.com/listings/19/cover.jpg', 'Northern lights through glass ceiling', TRUE,  '2020-04-01 07:00:00'),
(20, 'https://cdn.airbnb.com/listings/20/cover.jpg', 'Lake Ontario view from living room',    TRUE,  '2021-09-01 11:00:00');

-- -----------------------------------------------------------------------------
-- ListingAmenity (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO ListingAmenity (listing_id, amenity_id) VALUES
(1,  1),
(1,  3),
(1,  10),
(1,  11),
(2,  1),
(2,  3),
(3,  1),
(3,  3),
(3,  4),
(4,  1),
(4,  2),
(4,  17),
(5,  1),
(5,  2),
(5,  7),
(7,  7),
(7,  4),
(7,  18),
(10, 3),
(10, 4);

-- -----------------------------------------------------------------------------
-- Availability (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO Availability (listing_id, date, is_available, price_override) VALUES
(1,  '2025-07-01', TRUE,  NULL),
(1,  '2025-07-02', TRUE,  NULL),
(1,  '2025-07-03', FALSE, NULL),
(2,  '2025-07-01', TRUE,  NULL),
(2,  '2025-07-02', TRUE,  45.00),
(3,  '2025-08-10', TRUE,  NULL),
(3,  '2025-08-11', TRUE,  NULL),
(3,  '2025-08-12', FALSE, NULL),
(4,  '2025-07-15', TRUE,  NULL),
(4,  '2025-07-16', TRUE,  105.00),
(5,  '2025-08-01', TRUE,  NULL),
(5,  '2025-08-02', TRUE,  NULL),
(6,  '2025-07-20', TRUE,  NULL),
(6,  '2025-07-21', FALSE, NULL),
(7,  '2025-09-05', TRUE,  NULL),
(7,  '2025-09-06', TRUE,  350.00),
(9,  '2025-07-10', TRUE,  NULL),
(10, '2025-11-01', TRUE,  NULL),
(10, '2025-11-02', TRUE,  NULL),
(19, '2025-12-20', TRUE,  400.00);

-- -----------------------------------------------------------------------------
-- Wishlist (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO Wishlist (guest_id, wishlist_name, created_at) VALUES
(1,  'Europe Summer 2025',       '2024-11-01 10:00:00'),
(1,  'Weekend Getaways',         '2024-12-15 14:00:00'),
(3,  'Spain Trip',               '2025-01-10 09:00:00'),
(5,  'Remote Work Destinations', '2025-02-01 11:00:00'),
(5,  'Beach Holidays',           '2025-02-05 16:00:00'),
(7,  'Asia Pacific Adventure',   '2025-01-20 13:00:00'),
(9,  'Romantic Escapes',         '2024-10-01 18:00:00'),
(9,  'City Breaks',              '2024-10-05 09:00:00'),
(11, 'Digital Nomad Spots',      '2025-03-01 10:00:00'),
(11, 'South East Asia',          '2025-03-10 12:00:00'),
(13, 'First European Trip',      '2024-12-01 08:00:00'),
(14, 'Budget Stays',             '2024-09-15 09:00:00'),
(14, 'UK and Ireland',           '2025-01-05 14:30:00'),
(17, 'Business Travel',          '2024-08-01 07:00:00'),
(18, 'Hiking Bases',             '2025-04-01 11:00:00'),
(18, 'Nordic Countries',         '2025-04-10 13:00:00'),
(1,  'Winter Cabin Holidays',    '2025-05-01 09:00:00'),
(3,  'Mediterranean Islands',    '2025-03-15 10:00:00'),
(7,  'Luxury Collection',        '2025-02-10 15:00:00'),
(11, 'Long Stay Apartments',     '2025-04-20 08:00:00');

-- -----------------------------------------------------------------------------
-- SocialConnection (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO SocialConnection (user_id, platform, external_user_id, connected_at) VALUES
(1,  'Facebook',  'fb_alice_001',      '2022-03-15 10:00:00'),
(1,  'Google',    'google_alice_001',  '2022-03-15 10:05:00'),
(2,  'Facebook',  'fb_bob_002',        '2021-06-20 11:00:00'),
(3,  'Facebook',  'fb_clara_003',      '2023-01-10 09:00:00'),
(4,  'Facebook',  'fb_david_004',      '2020-12-01 08:00:00'),
(5,  'Google',    'google_emma_005',   '2022-09-05 12:00:00'),
(5,  'Facebook',  'fb_emma_005',       '2022-09-05 12:10:00'),
(6,  'Facebook',  'fb_faris_006',      '2021-03-25 10:00:00'),
(7,  'Facebook',  'fb_grace_007',      '2023-04-25 14:00:00'),
(8,  'Facebook',  'fb_henry_008',      '2019-08-10 08:00:00'),
(9,  'Facebook',  'fb_isabelle_009',   '2022-12-05 09:00:00'),
(9,  'Google',    'google_isabelle',   '2022-12-05 09:10:00'),
(10, 'Facebook',  'fb_james_010',      '2020-05-15 11:00:00'),
(11, 'Google',    'google_karen_011',  '2023-07-20 10:00:00'),
(12, 'Facebook',  'fb_luca_012',       '2018-10-01 08:00:00'),
(14, 'Google',    'google_nathan_014', '2023-03-01 09:00:00'),
(15, 'Facebook',  'fb_olivia_015',     '2019-04-20 10:00:00'),
(17, 'LinkedIn',  'li_quinn_017',      '2022-06-25 14:00:00'),
(18, 'Facebook',  'fb_rachel_018',     '2023-08-20 11:00:00'),
(19, 'Facebook',  'fb_samuel_019',     '2020-02-20 08:00:00');

-- -----------------------------------------------------------------------------
-- Booking (20 rows)
-- guest_id: Alice=1, Clara=3, Emma=5, Grace=7, Isabelle=9,
--           Karen=11, Mia=13, Nathan=14, Quinn=17, Rachel=18
-- -----------------------------------------------------------------------------
INSERT INTO Booking (guest_id, listing_id, check_in_date, check_out_date, num_guests, total_price, service_fee, status, created_at) VALUES
(1,  1,  '2025-07-01', '2025-07-05', 2, 530.00,   53.00,  'Completed', '2025-06-01 09:00:00'),
(3,  5,  '2025-08-01', '2025-08-08', 6, 3285.00,  295.65, 'Confirmed', '2025-07-10 10:00:00'),
(5,  4,  '2025-07-15', '2025-07-18', 1, 310.00,   27.90,  'Completed', '2025-07-01 11:00:00'),
(9,  11, '2025-06-10', '2025-06-13', 2, 420.00,   37.80,  'Completed', '2025-05-20 09:30:00'),
(11, 6,  '2025-07-20', '2025-07-23', 1, 570.00,   51.30,  'Confirmed', '2025-07-05 08:00:00'),
(14, 3,  '2025-08-10', '2025-08-15', 4, 1040.00,  93.60,  'Confirmed', '2025-07-20 10:00:00'),
(7,  8,  '2025-07-05', '2025-07-07', 2, 154.00,   13.86,  'Completed', '2025-06-25 14:00:00'),
(17, 2,  '2025-07-01', '2025-07-04', 1, 175.00,   15.75,  'Completed', '2025-06-15 09:00:00'),
(1,  9,  '2025-07-10', '2025-07-14', 2, 460.00,   41.40,  'Confirmed', '2025-06-28 12:00:00'),
(18, 10, '2025-11-01', '2025-11-05', 3, 750.00,   67.50,  'Pending',   '2025-10-01 08:00:00'),
(13, 7,  '2025-09-05', '2025-09-10', 4, 1660.00,  149.40, 'Confirmed', '2025-08-10 09:00:00'),
(3,  14, '2025-09-15', '2025-09-18', 2, 890.00,   80.10,  'Confirmed', '2025-08-25 11:00:00'),
(5,  17, '2025-08-20', '2025-08-24', 3, 585.00,   52.65,  'Pending',   '2025-08-01 10:00:00'),
(11, 20, '2025-10-01', '2025-10-04', 2, 495.00,   44.55,  'Confirmed', '2025-09-10 09:00:00'),
(9,  16, '2025-10-05', '2025-10-12', 5, 5370.00,  483.30, 'Confirmed', '2025-09-01 08:00:00'),
(14, 12, '2025-07-08', '2025-07-10', 1, 185.00,   16.65,  'Completed', '2025-06-30 10:00:00'),
(17, 15, '2025-07-12', '2025-07-14', 2, 145.00,   13.05,  'Completed', '2025-07-01 09:00:00'),
(7,  19, '2025-12-20', '2025-12-24', 2, 1475.00,  132.75, 'Pending',   '2025-11-01 10:00:00'),
(18, 13, '2025-07-01', '2025-07-03', 3, 65.00,    5.85,   'Cancelled', '2025-06-20 08:00:00'),
(17, 4,  '2025-07-22', '2025-07-25', 1, 310.00,   27.90,  'Completed', '2025-07-10 08:00:00');

-- -----------------------------------------------------------------------------
-- WishlistItem (20 rows)
-- wishlist_id 1=Alice-Europe, 2=Alice-Weekend, 3=Clara-Spain,
-- 4=Emma-Remote, 5=Emma-Beach, 7=Isabelle-Romantic, 8=Isabelle-City
-- -----------------------------------------------------------------------------
INSERT INTO WishlistItem (wishlist_id, listing_id, added_at) VALUES
(1,  5,  '2024-11-05 10:00:00'),
(1,  7,  '2024-11-06 11:00:00'),
(1,  9,  '2024-11-07 12:00:00'),
(2,  3,  '2024-12-16 09:00:00'),
(2,  12, '2024-12-17 10:00:00'),
(3,  5,  '2025-01-11 08:00:00'),
(3,  14, '2025-01-12 09:00:00'),
(4,  4,  '2025-02-02 10:00:00'),
(4,  8,  '2025-02-03 11:00:00'),
(4,  20, '2025-02-04 12:00:00'),
(5,  5,  '2025-02-06 09:00:00'),
(5,  6,  '2025-02-07 10:00:00'),
(7,  11, '2024-10-02 14:00:00'),
(7,  9,  '2024-10-03 15:00:00'),
(8,  1,  '2024-10-06 09:00:00'),
(8,  4,  '2024-10-07 10:00:00'),
(8,  11, '2024-10-08 11:00:00'),
(17, 1,  '2025-05-02 08:00:00'),
(17, 10, '2025-05-03 09:00:00'),
(17, 19, '2025-05-04 10:00:00');

-- -----------------------------------------------------------------------------
-- Report (20 rows) — disputes filed by various users
-- -----------------------------------------------------------------------------
INSERT INTO Report (reporter_id, reported_user_id, listing_id, reason, status, created_at) VALUES
(1,  8,  5,  'The villa was significantly different from the photos. Pool was not available.',                       'Open',      '2025-08-10 09:00:00'),
(3,  8,  14, 'Host was unresponsive after check-in. Heating was not working as advertised.',                         'Resolved',  '2025-09-20 10:00:00'),
(7,  15, 8,  'Room was not clean on arrival. Host did not respond to messages for 24 hours.',                        'Resolved',  '2025-07-08 11:00:00'),
(9,  2,  11, 'The listing stated Entire Place but another guest was present during the stay.',                        'Open',      '2025-06-14 08:00:00'),
(11, 10, 6,  'Apartment was smaller than described. Photos were misleading.',                                         'Dismissed', '2025-07-24 09:00:00'),
(14, 4,  3,  'Smoke alarm was not functional. Fire safety concern.',                                                  'Resolved',  '2025-08-16 10:00:00'),
(17, 6,  2,  'Host cancelled 12 hours before check-in with no alternative offered.',                                  'Open',      '2025-07-05 08:00:00'),
(18, 19, 10, 'Cabin was not stocked as advertised. No firewood provided for the stove.',                              'Resolved',  '2025-11-07 09:00:00'),
(13, 12, 7,  'Wifi was not working for the entire stay despite being listed as an amenity.',                          'Dismissed', '2025-09-12 10:00:00'),
(5,  16, 9,  'Check-in instructions were incorrect. We waited outside for 2 hours.',                                  'Resolved',  '2025-07-16 11:00:00'),
(1,  6,  4,  'Host entered the apartment without notice during our stay.',                                             'Open',      '2025-07-20 08:00:00'),
(3,  2,  1,  'Listing was not available on the dates shown despite being marked available online.',                    'Dismissed', '2025-07-03 09:00:00'),
(9,  12, 16, 'The villa pool was under construction and unusable for the entire stay.',                                'Open',      '2025-10-14 10:00:00'),
(11, 2,  20, 'The condo had a persistent noise issue from the floor above that made sleep difficult.',                 'Resolved',  '2025-10-06 08:00:00'),
(14, 15, 12, 'Host charged an additional cleaning fee not listed in the booking summary.',                             'Open',      '2025-07-12 09:00:00'),
(17, 10, 15, 'The shared kitchen was dirty and had items left by other guests.',                                       'Resolved',  '2025-07-15 10:00:00'),
(7,  19, 19, 'Northern lights were not visible but this is understood. However the heating failed on night 2.',        'Dismissed', '2025-12-26 08:00:00'),
(18, 6,  13, 'Shared bathroom was unacceptably dirty. Multiple guests complained.',                                    'Open',      '2025-07-04 09:00:00'),
(13, 8,  5,  'Host attempted to collect additional cash payment on arrival not included in the booking.',              'Open',      '2025-09-12 08:00:00'),
(5,  4,  3,  'Cottage was beautiful but the description said log fire was operational. It was not.',                   'Resolved',  '2025-08-17 11:00:00');

-- -----------------------------------------------------------------------------
-- Payment (20 rows — one per booking)
-- booking_id 1-20, currency matches listing country
-- -----------------------------------------------------------------------------
INSERT INTO Payment (booking_id, amount, currency, payment_method, payment_status, charged_at) VALUES
(1,  530.00,   'GBP', 'Credit Card', 'Paid',     '2025-06-01 09:05:00'),
(2,  3285.00,  'EUR', 'Credit Card', 'Paid',     '2025-07-10 10:05:00'),
(3,  310.00,   'EUR', 'Credit Card', 'Paid',     '2025-07-01 11:05:00'),
(4,  420.00,   'EUR', 'Credit Card', 'Paid',     '2025-05-20 09:35:00'),
(5,  570.00,   'AUD', 'Credit Card', 'Paid',     '2025-07-05 08:05:00'),
(6,  1040.00,  'GBP', 'Credit Card', 'Paid',     '2025-07-20 10:05:00'),
(7,  154.00,   'SEK', 'Credit Card', 'Paid',     '2025-06-25 14:05:00'),
(8,  175.00,   'EUR', 'Credit Card', 'Paid',     '2025-06-15 09:05:00'),
(9,  460.00,   'EUR', 'Credit Card', 'Paid',     '2025-06-28 12:05:00'),
(10, 750.00,   'NOK', 'Credit Card', 'Pending',  '2025-10-01 08:05:00'),
(11, 1660.00,  'EUR', 'Credit Card', 'Paid',     '2025-08-10 09:05:00'),
(12, 890.00,   'EUR', 'Credit Card', 'Paid',     '2025-08-25 11:05:00'),
(13, 585.00,   'SEK', 'Credit Card', 'Pending',  '2025-08-01 10:05:00'),
(14, 495.00,   'CAD', 'Credit Card', 'Paid',     '2025-09-10 09:05:00'),
(15, 5370.00,  'EUR', 'Credit Card', 'Paid',     '2025-09-01 08:05:00'),
(16, 185.00,   'EUR', 'Credit Card', 'Paid',     '2025-06-30 10:05:00'),
(17, 145.00,   'SEK', 'Credit Card', 'Paid',     '2025-07-01 09:05:00'),
(18, 1475.00,  'NOK', 'Credit Card', 'Pending',  '2025-11-01 10:05:00'),
(19, 65.00,    'EUR', 'Credit Card', 'Refunded', '2025-06-20 08:05:00'),
(20, 310.00,   'EUR', 'Credit Card', 'Paid',     '2025-07-10 08:05:00');

-- -----------------------------------------------------------------------------
-- Payout (20 rows)
-- Amount = total_price - service_fee - 3% host commission on (total - service_fee)
-- host_fee_deducted = (total_price - service_fee) * 0.03
-- host_paid_at = check_in_date + 24 hours (for Completed/Confirmed bookings)
-- -----------------------------------------------------------------------------
INSERT INTO Payout (booking_id, host_id, amount, host_fee_deducted, payout_status, host_paid_at) VALUES
(1,  2,  461.31,  14.31,   'Paid',    '2025-07-02 09:00:00'),
(2,  8,  2902.54, 87.04,   'Pending', NULL),
(3,  6,  274.83,  7.83,    'Paid',    '2025-07-16 09:00:00'),
(4,  2,  370.86,  11.34,   'Paid',    '2025-06-11 09:00:00'),
(5,  10, 504.51,  14.49,   'Pending', NULL),
(6,  4,  917.82,  28.62,   'Pending', NULL),
(7,  15, 137.44,  2.72,    'Paid',    '2025-07-06 09:00:00'),
(8,  2,  154.95,  4.80,    'Paid',    '2025-07-02 09:00:00'),
(9,  16, 406.98,  11.22,   'Pending', NULL),
(10, 19, 662.48,  20.00,   'Pending', NULL),
(11, 12, 1467.86, 43.68,   'Pending', NULL),
(12, 8,  787.20,  24.30,   'Pending', NULL),
(13, 15, 516.87,  15.87,   'Pending', NULL),
(14, 2,  437.55,  13.35,   'Pending', NULL),
(15, 12, 4744.71, 146.01,  'Pending', NULL),
(16, 4,  163.52,  4.83,    'Paid',    '2025-07-09 09:00:00'),
(17, 10, 128.17,  3.93,    'Paid',    '2025-07-13 09:00:00'),
(18, 19, 1302.44, 40.27,   'Pending', NULL),
(19, 6, 100.00, 3.00, 'Pending', NULL),
(20, 6,  274.83,  7.83,    'Paid',    '2025-07-23 09:00:00');

-- -----------------------------------------------------------------------------
-- Review (20 rows — only for Completed bookings)
-- Completed booking IDs: 1, 3, 4, 7, 8, 16, 17, 20
-- Each generates 2 reviews (guest reviews host, host reviews guest)
-- -----------------------------------------------------------------------------
INSERT INTO Review (booking_id, reviewer_id, reviewee_id, rating, comment, review_type, created_at) VALUES
-- Booking 1: Alice (1) stayed at Bob's (2) London flat
(1,  1,  2,  5, 'Bob was a fantastic host. The flat was exactly as described — spotless and well located.',     'guest_review', '2025-07-06 10:00:00'),
(1,  2,  1,  5, 'Alice was a wonderful guest. Left the flat in perfect condition.',                              'host_review',  '2025-07-07 09:00:00'),
-- Booking 3: Emma (5) stayed at Faris (6) Berlin apartment
(3,  5,  6,  4, 'Great apartment with a fantastic location. Minor issue with the air conditioning on day 2.',   'guest_review', '2025-07-19 10:00:00'),
(3,  6,  5,  5, 'Emma was a respectful and tidy guest. Would host again.',                                       'host_review',  '2025-07-20 09:00:00'),
-- Booking 4: Isabelle (9) stayed at Bob (2) Paris studio
(4,  9,  2,  5, 'The Parisian studio is a gem. Bob was responsive and the location is unbeatable.',             'guest_review', '2025-06-14 10:00:00'),
(4,  2,  9,  4, 'Isabelle was a pleasant guest. Flat was in good order on checkout.',                            'host_review',  '2025-06-15 09:00:00'),
-- Booking 7: Grace (7) stayed at Olivia (15) Stockholm room
(7,  7,  15, 5, 'Olivia is a superhost for a reason. The room was perfect and she gave great local tips.',      'guest_review', '2025-07-08 10:00:00'),
(7,  15, 7,  4, 'Grace was friendly and easy to communicate with. Would welcome back.',                          'host_review',  '2025-07-09 09:00:00'),
-- Booking 8: Quinn (17) stayed at Bob (2) Berlin private room
(8,  17, 2,  4, 'Good value for money in a prime Berlin location. Host was quick to respond.',                  'guest_review', '2025-07-05 10:00:00'),
(8,  2,  17, 5, 'Quinn was an excellent guest — quiet and tidy throughout the stay.',                            'host_review',  '2025-07-06 09:00:00'),
-- Booking 16: Nathan (14) stayed at David (4) Covent Garden room
(16, 14, 4,  5, 'David is an outstanding host. The room was immaculate and the location is incredible.',        'guest_review', '2025-07-11 10:00:00'),
(16, 4,  14, 5, 'Nathan was a model guest. Highly recommended.',                                                 'host_review',  '2025-07-12 09:00:00'),
-- Booking 17: Quinn (17) stayed at James (10) Melbourne room
(17, 17, 10, 4, 'Clean and comfortable room in a great location. James was helpful and friendly.',              'guest_review', '2025-07-15 10:00:00'),
(17, 10, 17, 4, 'Quinn was a good guest. No issues at all.',                                                     'host_review',  '2025-07-16 09:00:00'),
-- Booking 20: Quinn (17) stayed at Faris (6) Berlin apartment
(20, 17, 6,  5, 'Second time staying with Faris and once again a perfect experience.',                          'guest_review', '2025-07-26 10:00:00'),
(20, 6,  17, 5, 'Quinn is a returning guest and always a pleasure to host.',                                     'host_review',  '2025-07-27 09:00:00');

-- Four additional reviews for other bookings to reach 20 total rows.
INSERT INTO Review (booking_id, reviewer_id, reviewee_id, rating, comment, review_type, created_at) VALUES
(2,  3,  8,  5, 'Henry\'s Barcelona villa exceeded all expectations. Pool, beach, and perfect weather.',                   'guest_review', '2025-08-10 10:00:00'),
(2,  8,  3,  5, 'Clara and her group were respectful guests. The villa was left in excellent condition.',                 'host_review',  '2025-08-10 11:00:00'),
(11, 13, 12, 4, 'The Tuscan farmhouse was stunning. Luca was an attentive and knowledgeable host.',                      'guest_review', '2025-09-12 10:00:00'),
(11, 12, 13, 5, 'Mia was a delightful first-time guest. Very respectful and enthusiastic about the property.',           'host_review',  '2025-09-12 11:00:00');


-- -----------------------------------------------------------------------------
-- Notification (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO Notification (user_id, notification_type, message, is_read, created_at) VALUES
(1,  'Booking',  'Your booking at Charming London Flat has been confirmed.',                   TRUE,  '2025-06-01 09:10:00'),
(2,  'Booking',  'You have a new booking request for your London flat from Alice Johnson.',    TRUE,  '2025-06-01 09:10:00'),
(3,  'Booking',  'Your booking at Beachfront Villa in Barcelona has been confirmed.',          TRUE,  '2025-07-10 10:10:00'),
(8,  'Booking',  'You have a new booking request for your Barcelona villa from Clara.',        TRUE,  '2025-07-10 10:10:00'),
(5,  'Booking',  'Your booking at Modern Apartment near Brandenburg Gate is confirmed.',       TRUE,  '2025-07-01 11:10:00'),
(1,  'Payment',  'Payment of GBP 530.00 for your London booking has been processed.',         TRUE,  '2025-06-01 09:15:00'),
(2,  'Payment',  'Payout of GBP 461.31 for booking #1 has been sent to your account.',       TRUE,  '2025-07-02 09:10:00'),
(1,  'Review',   'Your stay at the London flat is complete. Please leave a review.',           TRUE,  '2025-07-05 10:00:00'),
(2,  'Review',   'Alice Johnson has left a 5-star review for your London flat.',              TRUE,  '2025-07-06 10:05:00'),
(17, 'Booking',  'Your booking at Private Room in Berlin Mitte has been confirmed.',           TRUE,  '2025-06-15 09:10:00'),
(7,  'Booking',  'Your booking at Private Room in Stockholm is confirmed.',                    TRUE,  '2025-06-25 14:10:00'),
(15, 'Review',   'Grace Kim has left you a 5-star review. Great work!',                       FALSE, '2025-07-08 10:05:00'),
(9,  'Booking',  'Your booking at the Lisbon Sea-View Apartment is confirmed.',                FALSE, '2025-06-28 12:10:00'),
(18, 'Booking',  'Your booking at the Norwegian Fjord Cabin is pending host approval.',        FALSE, '2025-10-01 08:10:00'),
(19, 'Booking',  'You have a new booking request for your Fjord Cabin from Rachel Taylor.',   FALSE, '2025-10-01 08:10:00'),
(13, 'Booking',  'Your booking at Tuscan Farmhouse with Vineyard is confirmed.',               FALSE, '2025-08-10 09:10:00'),
(14, 'Review',   'Your stay at the Covent Garden room is complete. Please leave a review.',   TRUE,  '2025-07-10 10:00:00'),
(18, 'Booking',  'Your booking at the Shared Dorm in Berlin has been cancelled.',             TRUE,  '2025-06-20 08:10:00'),
(11, 'Payment',  'Payment of AUD 570.00 for your Sydney booking has been processed.',         FALSE, '2025-07-05 08:10:00'),
(9,  'Review',   'Please review your recent stay at the Amalfi Coast Villa.',                 FALSE, '2025-10-13 10:00:00');

-- -----------------------------------------------------------------------------
-- Message (20 rows)
-- -----------------------------------------------------------------------------
INSERT INTO Message (booking_id, sender_id, receiver_id, message_body, sent_at, is_read) VALUES
(1,  1,  2,  'Hi Bob, looking forward to our stay! What time can we check in?',                                  '2025-06-15 10:00:00', TRUE),
(1,  2,  1,  'Hi Alice! Check-in is from 3pm. I will leave the keys in the lockbox — code is 4821.',            '2025-06-15 10:30:00', TRUE),
(2,  3,  8,  'Hola Henry! We are a group of 6 adults. Will the villa pool be heated in August?',                 '2025-07-11 09:00:00', TRUE),
(2,  8,  3,  'Hi Clara! Yes the pool is heated year round. Looking forward to welcoming your group.',            '2025-07-11 10:00:00', TRUE),
(3,  5,  6,  'Hi Faris, will there be a workspace I can use for video calls?',                                   '2025-07-02 08:00:00', TRUE),
(3,  6,  5,  'Hi Emma, yes there is a dedicated desk with fast WiFi, perfect for remote work.',                  '2025-07-02 09:00:00', TRUE),
(4,  9,  2,  'Bonjour Bob! Is the studio near any good bakeries? We love a proper French breakfast.',            '2025-05-21 10:00:00', TRUE),
(4,  2,  9,  'Bonjour Isabelle! There is a wonderful boulangerie just around the corner on Rue Saint-Honore.', '2025-05-21 11:00:00', TRUE),
(6,  14, 4,  'Hi David, we arrive late on the 10th around 11pm. Is that okay for check-in?',                    '2025-07-25 09:00:00', TRUE),
(6,  4,  14, 'Hi Nathan, no problem at all. I will arrange a self-check-in with the lockbox for you.',          '2025-07-25 10:00:00', FALSE),
(7,  7,  15, 'Hi Olivia! Do you have recommendations for things to do in Sodermalm?',                            '2025-06-26 11:00:00', TRUE),
(7,  15, 7,  'Hi Grace! Sodermalm is amazing. I will send you my personal neighbourhood guide on arrival.',     '2025-06-26 12:00:00', TRUE),
(8,  17, 2,  'Hi Bob, just confirming — does the Berlin room have its own bathroom or is it shared?',            '2025-06-16 08:00:00', TRUE),
(8,  2,  17, 'Hi Quinn, the room has access to a shared bathroom used only by the one other room.',             '2025-06-16 09:00:00', TRUE),
(10, 18, 19, 'Hi Samuel, is the cabin accessible by normal car or do we need a 4x4?',                           '2025-10-02 10:00:00', TRUE),
(10, 19, 18, 'Hi Rachel! A normal car is fine. The road is paved all the way to the cabin.',                    '2025-10-02 11:00:00', FALSE),
(11, 13, 12, 'Ciao Luca! Will you be available to give us a tour of the vineyard during our stay?',              '2025-08-11 09:00:00', TRUE),
(11, 12, 13, 'Ciao Mia! Absolutely — I will be on-site on the first day and would love to show you around.',   '2025-08-11 10:00:00', FALSE),
(15, 9,  12, 'Hi Luca, we are celebrating a birthday. Any chance of a welcome bottle of wine?',                  '2025-09-02 09:00:00', TRUE),
(15, 12, 9,  'Ciao Isabelle! Of course — a bottle of our own Chianti will be waiting for you on arrival.',      '2025-09-02 10:00:00', TRUE);