-- =============================================================================
-- Database Schema

DROP DATABASE IF EXISTS airbnb_db;
CREATE DATABASE airbnb_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airbnb_db;

-- =============================================================================
-- TABLE CREATION
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Country
-- Purpose: Reference table for countries and currencies.
-- Primary Key: country_id
--          Used by Listing to record where a property is located.
-- -----------------------------------------------------------------------------
CREATE TABLE Country (
    country_id      INT          NOT NULL AUTO_INCREMENT,
    country_name    VARCHAR(100) NOT NULL,
    country_code    CHAR(2)      NOT NULL,
    currency_code   CHAR(3)      NOT NULL,
    currency_symbol VARCHAR(5)   NOT NULL,
    CONSTRAINT pk_country      PRIMARY KEY (country_id),
    CONSTRAINT uq_country_name UNIQUE (country_name),
    CONSTRAINT uq_country_code UNIQUE (country_code)
);

-- -----------------------------------------------------------------------------
-- 2. ListingType
-- Purpose: Lookup table for accommodation categories
-- Primary Key: listing_type_id
--          (Entire Place, Private Room, Shared Room).
-- -----------------------------------------------------------------------------
CREATE TABLE ListingType (
    listing_type_id INT         NOT NULL AUTO_INCREMENT,
    type_name       VARCHAR(50) NOT NULL,
    description     TEXT,
    CONSTRAINT pk_listing_type      PRIMARY KEY (listing_type_id),
    CONSTRAINT uq_listing_type_name UNIQUE (type_name)
);

-- -----------------------------------------------------------------------------
-- 3. CancellationPolicy
-- Purpose: Defines refund rules attached to a listing.
-- Primary Key: policy_id
-- -----------------------------------------------------------------------------
CREATE TABLE CancellationPolicy (
    policy_id           INT          NOT NULL AUTO_INCREMENT,
    policy_name         VARCHAR(100) NOT NULL,
    description         TEXT         NOT NULL,
    refund_percentage   DECIMAL(5,2) NOT NULL,
    days_before_checkin INT          NOT NULL,
    CONSTRAINT pk_cancellation_policy      PRIMARY KEY (policy_id),
    CONSTRAINT uq_cancellation_policy_name UNIQUE (policy_name),
    CONSTRAINT chk_refund_pct   CHECK (refund_percentage BETWEEN 0 AND 100),
    CONSTRAINT chk_days_before  CHECK (days_before_checkin >= 0)
);

-- -----------------------------------------------------------------------------
-- 4. Amenity
-- Purpose: Master catalogue of amenities a listing can offer.
-- Primary Key: amenity_id
--          Linked to listings via the ListingAmenity join table.
-- -----------------------------------------------------------------------------
CREATE TABLE Amenity (
    amenity_id       INT          NOT NULL AUTO_INCREMENT,
    amenity_name     VARCHAR(100) NOT NULL,
    amenity_category VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_amenity      PRIMARY KEY (amenity_id),
    CONSTRAINT uq_amenity_name UNIQUE (amenity_name)
);

-- -----------------------------------------------------------------------------
-- 5. User
-- Purpose: Single table for all platform users (Guest, Host, Admin).
-- Primary Key: user_id
-- Important Constraints: email has to be unique, role is ENUM
--          The role field controls what each user can do on the platform.
-- -----------------------------------------------------------------------------
CREATE TABLE User (
    user_id         INT          NOT NULL AUTO_INCREMENT,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    email           VARCHAR(100) NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    phone_number    VARCHAR(20),
    profile_picture VARCHAR(255),
    bio             TEXT,
    role            ENUM('Guest','Host','Admin') NOT NULL,
    date_joined     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_verified     BOOLEAN      NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_user       PRIMARY KEY (user_id),
    CONSTRAINT uq_user_email UNIQUE (email)
);

-- -----------------------------------------------------------------------------
-- 6. Listing
-- Purpose: Core accommodation record published by a host.
-- Primary Key: listing_id
-- Relational Constraints:
--       host_id must reference an existing User.
--       listing_type_id must reference a valid ListingType (e.g., house, room).
--       country_id must reference a valid Country.
--       cancellation_policy_id must reference a valid CancellationPolicy.
-- 
-- Business Logic Constraints:
--       price_per_night must be strictly greater than $0.
--       cleaning_fee cannot be negative (defaults to $0.00).
--       min_stay_nights must be at least 1 night (defaults to 1).
--       max_guests must accommodate at least 1 guest.
-- 
-- Data Integrity:
--       Core geographical (lat/long, address) and descriptive (title) fields cannot be null.
--       Listings are defaulted to active (is_active = TRUE) upon creation.
--          References User(host), ListingType, Country, CancellationPolicy.
-- -----------------------------------------------------------------------------
CREATE TABLE Listing (
    listing_id             INT           NOT NULL AUTO_INCREMENT,
    host_id                INT           NOT NULL,
    listing_type_id        INT           NOT NULL,
    country_id             INT           NOT NULL,
    cancellation_policy_id INT           NOT NULL,
    title                  VARCHAR(150)  NOT NULL,
    description            TEXT          NOT NULL,
    address                VARCHAR(255)  NOT NULL,
    city                   VARCHAR(100)  NOT NULL,
    latitude               DECIMAL(9,6)  NOT NULL,
    longitude              DECIMAL(9,6)  NOT NULL,
    price_per_night        DECIMAL(10,2) NOT NULL,
    cleaning_fee           DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    min_stay_nights        INT           NOT NULL DEFAULT 1,
    max_guests             INT           NOT NULL,
    is_active              BOOLEAN       NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_listing                PRIMARY KEY (listing_id),
    CONSTRAINT fk_listing_host           FOREIGN KEY (host_id)
        REFERENCES User(user_id),
    CONSTRAINT fk_listing_type           FOREIGN KEY (listing_type_id)
        REFERENCES ListingType(listing_type_id),
    CONSTRAINT fk_listing_country        FOREIGN KEY (country_id)
        REFERENCES Country(country_id),
    CONSTRAINT fk_listing_cancel_policy  FOREIGN KEY (cancellation_policy_id)
        REFERENCES CancellationPolicy(policy_id),
    CONSTRAINT chk_price_positive        CHECK (price_per_night > 0),
    CONSTRAINT chk_cleaning_fee          CHECK (cleaning_fee >= 0),
    CONSTRAINT chk_min_stay              CHECK (min_stay_nights >= 1),
    CONSTRAINT chk_max_guests            CHECK (max_guests >= 1)
);

-- -----------------------------------------------------------------------------
-- 7. Room
-- Purpose: Individual rooms within a listing (bedroom, bathroom, kitchen, etc.)
-- Primary Key: room_id
-- 
-- Relational Constraints:
--       listing_id must reference an existing parent Listing.
-- 
-- Business Logic Constraints:
--       num_beds cannot be a negative number.
-- 
-- Data Integrity:
--       Room naming (room_name) and categorization (room_type) are mandatory.
--       num_beds defaults to 0 to easily accommodate non-sleeping rooms (e.g., kitchens, bathrooms)
-- -----------------------------------------------------------------------------
CREATE TABLE Room (
    room_id    INT          NOT NULL AUTO_INCREMENT,
    listing_id INT          NOT NULL,
    room_name  VARCHAR(100) NOT NULL,
    room_type  VARCHAR(50)  NOT NULL,
    num_beds   INT          NOT NULL DEFAULT 0,
    CONSTRAINT pk_room         PRIMARY KEY (room_id),
    CONSTRAINT fk_room_listing FOREIGN KEY (listing_id)
        REFERENCES Listing(listing_id),
    CONSTRAINT chk_num_beds    CHECK (num_beds >= 0)
);

-- -----------------------------------------------------------------------------
-- 8. ListingPhoto
-- Purpose: Photos uploaded for a listing. One photo flagged as cover image.
-- -----------------------------------------------------------------------------
CREATE TABLE ListingPhoto (
    photo_id    INT          NOT NULL AUTO_INCREMENT,
    listing_id  INT          NOT NULL,
    photo_url   VARCHAR(255) NOT NULL,
    caption     VARCHAR(150),
    is_cover    BOOLEAN      NOT NULL DEFAULT FALSE,
    uploaded_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_listing_photo         PRIMARY KEY (photo_id),
    CONSTRAINT fk_listing_photo_listing FOREIGN KEY (listing_id)
        REFERENCES Listing(listing_id)
);

-- -----------------------------------------------------------------------------
-- 9. ListingAmenity  [TRIPLE RELATIONSHIP 1]
-- Purpose: Join table — Listing x Amenity.
--          Triple relationship: a Host (User) configures which Amenities
--          are available at a specific Listing.
--          Three entities involved: User (host) + Listing + Amenity.
-- -----------------------------------------------------------------------------
CREATE TABLE ListingAmenity (
    listing_id INT NOT NULL,
    amenity_id INT NOT NULL,
    CONSTRAINT pk_listing_amenity         PRIMARY KEY (listing_id, amenity_id),
    CONSTRAINT fk_listing_amenity_listing FOREIGN KEY (listing_id)
        REFERENCES Listing(listing_id),
    CONSTRAINT fk_listing_amenity_amenity FOREIGN KEY (amenity_id)
        REFERENCES Amenity(amenity_id)
);

-- -----------------------------------------------------------------------------
-- 10. Availability
-- Purpose: Date-level calendar per listing showing open or blocked dates.
--          price_override allows custom pricing on specific dates.
-- -----------------------------------------------------------------------------
CREATE TABLE Availability (
    availability_id INT           NOT NULL AUTO_INCREMENT,
    listing_id      INT           NOT NULL,
    date            DATE          NOT NULL,
    is_available    BOOLEAN       NOT NULL DEFAULT TRUE,
    price_override  DECIMAL(10,2),
    CONSTRAINT pk_availability         PRIMARY KEY (availability_id),
    CONSTRAINT fk_availability_listing FOREIGN KEY (listing_id)
        REFERENCES Listing(listing_id),
    CONSTRAINT uq_availability         UNIQUE (listing_id, date)
);

-- -----------------------------------------------------------------------------
-- 11. Wishlist
-- Purpose: A named collection of saved listings belonging to a guest.
-- -----------------------------------------------------------------------------
CREATE TABLE Wishlist (
    wishlist_id   INT          NOT NULL AUTO_INCREMENT,
    guest_id      INT          NOT NULL,
    wishlist_name VARCHAR(100) NOT NULL,
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_wishlist       PRIMARY KEY (wishlist_id),
    CONSTRAINT fk_wishlist_guest FOREIGN KEY (guest_id)
        REFERENCES User(user_id)
);

-- -----------------------------------------------------------------------------
-- 12. SocialConnection
-- Purpose: Social network accounts linked to a user profile.
--          Enables display of reviews from mutual social contacts.
-- -----------------------------------------------------------------------------
CREATE TABLE SocialConnection (
    connection_id    INT          NOT NULL AUTO_INCREMENT,
    user_id          INT          NOT NULL,
    platform         VARCHAR(50)  NOT NULL,
    external_user_id VARCHAR(100) NOT NULL,
    connected_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_social_connection      PRIMARY KEY (connection_id),
    CONSTRAINT fk_social_connection_user FOREIGN KEY (user_id)
        REFERENCES User(user_id)
);

-- -----------------------------------------------------------------------------
-- 13. Notification
-- Purpose: Platform-generated alerts sent to users (booking updates,
--          payment confirmations, new messages, review prompts, etc.)
-- -----------------------------------------------------------------------------
CREATE TABLE Notification (
    notification_id   INT         NOT NULL AUTO_INCREMENT,
    user_id           INT         NOT NULL,
    notification_type VARCHAR(50) NOT NULL,
    message           TEXT        NOT NULL,
    is_read           BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at        DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_notification      PRIMARY KEY (notification_id),
    CONSTRAINT fk_notification_user FOREIGN KEY (user_id)
        REFERENCES User(user_id)
);

-- -----------------------------------------------------------------------------
-- 14. Booking
-- Purpose: Core reservation record linking Guest, Listing, and date range.
-- Relational Constraints:
--       guest_id must reference an existing User making the booking.
--       listing_id must reference an existing Listing being booked.
-- 
-- Business Logic Constraints:
--       check_out_date must be strictly after the check_in_date.
--       num_guests must be at least 1.
--       total_price must be greater than $0.
--       service_fee cannot be negative.
-- 
-- Data Integrity & Lifecycle:
--       status: Restricted to 'Pending', 'Confirmed', 'Completed', or 'Cancelled'.
--                Defaults to 'Pending' upon creation.
--       created_at: Automatically records the exact moment the booking is created.
--          
-- -----------------------------------------------------------------------------
CREATE TABLE Booking (
    booking_id     INT           NOT NULL AUTO_INCREMENT,
    guest_id       INT           NOT NULL,
    listing_id     INT           NOT NULL,
    check_in_date  DATE          NOT NULL,
    check_out_date DATE          NOT NULL,
    num_guests     INT           NOT NULL,
    total_price    DECIMAL(10,2) NOT NULL,
    service_fee    DECIMAL(10,2) NOT NULL,
    status         ENUM('Pending','Confirmed','Completed','Cancelled') NOT NULL DEFAULT 'Pending',
    created_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_booking         PRIMARY KEY (booking_id),
    CONSTRAINT fk_booking_guest   FOREIGN KEY (guest_id)
        REFERENCES User(user_id),
    CONSTRAINT fk_booking_listing FOREIGN KEY (listing_id)
        REFERENCES Listing(listing_id),
    CONSTRAINT chk_booking_dates  CHECK (check_out_date > check_in_date),
    CONSTRAINT chk_num_guests_bk  CHECK (num_guests >= 1),
    CONSTRAINT chk_total_price    CHECK (total_price > 0),
    CONSTRAINT chk_service_fee    CHECK (service_fee >= 0)
);

-- -----------------------------------------------------------------------------
-- 15. WishlistItem
-- Purpose: Join table mapping Listings to a specific Wishlist.
-- Primary Key: Composite (wishlist_id, listing_id) to prevent duplicate saves.
-- 
-- Relational Constraints:
--      - wishlist_id: Must reference an existing Wishlist (which inherently links to a Guest/User).
--      - listing_id: Must reference an existing Listing being favorited.
-- 
-- Business Logic & Data Integrity:
--      - Composite Primary Key ensures a listing can only be added to a specific wishlist once.
--      - added_at: Automatically captures the timestamp when the item was saved.
-- -----------------------------------------------------------------------------
CREATE TABLE WishlistItem (
    wishlist_id INT      NOT NULL,
    listing_id  INT      NOT NULL,
    added_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_wishlist_item          PRIMARY KEY (wishlist_id, listing_id),
    CONSTRAINT fk_wishlist_item_wishlist FOREIGN KEY (wishlist_id)
        REFERENCES Wishlist(wishlist_id),
    CONSTRAINT fk_wishlist_item_listing  FOREIGN KEY (listing_id)
        REFERENCES Listing(listing_id)
);

-- -----------------------------------------------------------------------------
-- 16. Report
-- Purpose: Dispute or abuse reports filed by users.
-- Primary Key: report_id
-- 
-- Relational Constraints & Roles:
--      - reporter_id: Must reference an existing User (the one filing the complaint).
--      - reported_user_id: Must reference an existing User (the one being accused).
--      - listing_id: (Optional) References a Listing if the dispute is property-specific.
-- 
-- Business Logic & Data Integrity:
--      - reason: A text description is mandatory to file a report.
--      - status: Restricted to a customer support workflow ('Open', 'Resolved', 'Dismissed').
--                Defaults to 'Open' upon creation.
--      - created_at: Automatically captures the exact timestamp the report was filed.
-- -----------------------------------------------------------------------------
CREATE TABLE Report (
    report_id        INT      NOT NULL AUTO_INCREMENT,
    reporter_id      INT      NOT NULL,
    reported_user_id INT      NOT NULL,
    listing_id       INT,
    reason           TEXT     NOT NULL,
    status           ENUM('Open','Resolved','Dismissed') NOT NULL DEFAULT 'Open',
    created_at       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_report               PRIMARY KEY (report_id),
    CONSTRAINT fk_report_reporter      FOREIGN KEY (reporter_id)
        REFERENCES User(user_id),
    CONSTRAINT fk_report_reported_user FOREIGN KEY (reported_user_id)
        REFERENCES User(user_id),
    CONSTRAINT fk_report_listing       FOREIGN KEY (listing_id)
        REFERENCES Listing(listing_id)
);

-- -----------------------------------------------------------------------------
-- 17. Payment
-- Purpose: Financial transaction record for each booking (guest -> platform).
-- Primary Key: payment_id
-- 
-- Relational Constraints:
--      - booking_id: Must reference a valid, existing Booking.
-- 
-- Business Logic Constraints:
--      - amount: Must be strictly greater than $0 (refunds handled via status update, not negative rows).
-- 
-- Data Integrity & Lifecycle:
--      - payment_status: Restricted to 'Pending', 'Paid', or 'Refunded'.
--                        Defaults to 'Pending' upon creation.
--      - currency & payment_method: Mandatory fields for financial traceability.
--      - charged_at: Automatically captures the exact timestamp the payment was initiated.
-- -----------------------------------------------------------------------------
CREATE TABLE Payment (
    payment_id     INT           NOT NULL AUTO_INCREMENT,
    booking_id     INT           NOT NULL,
    amount         DECIMAL(10,2) NOT NULL,
    currency       VARCHAR(10)   NOT NULL,
    payment_method VARCHAR(50)   NOT NULL,
    payment_status ENUM('Pending','Paid','Refunded') NOT NULL DEFAULT 'Pending',
    charged_at     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_payment          PRIMARY KEY (payment_id),
    CONSTRAINT fk_payment_booking  FOREIGN KEY (booking_id)
        REFERENCES Booking(booking_id),
    CONSTRAINT chk_payment_amount  CHECK (amount > 0)
);

-- -----------------------------------------------------------------------------
-- 18. Payout
-- Purpose: Financial record of funds disbursed to the host.
-- Primary Key: payout_id
-- 
-- Relational Constraints:
--      - booking_id: Must reference a valid Booking.
--      - host_id: Must reference a valid User (denormalized for faster ledger queries).
-- 
-- Business Logic Constraints:
--      - amount: Payout must be strictly greater than $0.
--      - host_fee_deducted: The platform commission cannot be negative.
-- 
-- Data Integrity & Lifecycle:
--      - payout_status: Restricted to 'Pending' or 'Paid'. Defaults to 'Pending'.
--      - host_paid_at: Nullable; should be populated only when status transitions to 'Paid'.
-- -----------------------------------------------------------------------------
CREATE TABLE Payout (
    payout_id         INT           NOT NULL AUTO_INCREMENT,
    booking_id        INT           NOT NULL,
    host_id           INT           NOT NULL,
    amount            DECIMAL(10,2) NOT NULL,
    host_fee_deducted DECIMAL(10,2) NOT NULL,
    payout_status     ENUM('Pending','Paid') NOT NULL DEFAULT 'Pending',
    host_paid_at      DATETIME,
    CONSTRAINT pk_payout         PRIMARY KEY (payout_id),
    CONSTRAINT fk_payout_booking FOREIGN KEY (booking_id)
        REFERENCES Booking(booking_id),
    CONSTRAINT fk_payout_host    FOREIGN KEY (host_id)
        REFERENCES User(user_id),
    CONSTRAINT chk_payout_amount CHECK (amount > 0),
    CONSTRAINT chk_host_fee      CHECK (host_fee_deducted >= 0)
);

-- -----------------------------------------------------------------------------
-- 19. Review
-- Purpose: Bidirectional review system — guest reviews host, or host reviews guest.
-- Primary Key: review_id
-- 
-- Relational Constraints & Roles:
--      - booking_id: Must reference the specific Booking where the stay occurred.
--      - reviewer_id: Must reference an existing User writing the review.
--      - reviewee_id: Must reference an existing User receiving the review.
-- 
-- Business Logic Constraint:
--      - rating: Must be a standard 1 to 5 star rating.
-- 
-- Data Integrity:
--      - review_type: Strictly defined as either 'guest_review' or 'host_review'.
--      - comment: Optional (nullable) to allow star-only ratings.
--      - created_at: Automatically captures the timestamp of submission.
-- -----------------------------------------------------------------------------
CREATE TABLE Review (
    review_id   INT      NOT NULL AUTO_INCREMENT,
    booking_id  INT      NOT NULL,
    reviewer_id INT      NOT NULL,
    reviewee_id INT      NOT NULL,
    rating      TINYINT  NOT NULL,
    comment     TEXT,
    review_type ENUM('guest_review','host_review') NOT NULL,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_review          PRIMARY KEY (review_id),
    CONSTRAINT fk_review_booking  FOREIGN KEY (booking_id)
        REFERENCES Booking(booking_id),
    CONSTRAINT fk_review_reviewer FOREIGN KEY (reviewer_id)
        REFERENCES User(user_id),
    CONSTRAINT fk_review_reviewee FOREIGN KEY (reviewee_id)
        REFERENCES User(user_id),
    CONSTRAINT chk_rating         CHECK (rating BETWEEN 1 AND 5)
);

-- -----------------------------------------------------------------------------
-- 20. Message
-- Purpose: Direct messages between guest and host, strictly contextualized by a booking.
-- Primary Key: message_id
-- 
-- Relational Constraints & Roles:
--      - booking_id: Must reference an existing Booking.
--      - sender_id: Must reference a valid User originating the message.
--      - receiver_id: Must reference a valid User receiving the message.
-- 
-- Data Integrity & UI State:
--      - message_body: Cannot be blank or null.
--      - is_read: Tracks message read status; automatically defaults to FALSE (unread).
--      - sent_at: Automatically captures the exact timestamp the message was sent.
-- -----------------------------------------------------------------------------
CREATE TABLE Message (
    message_id   INT      NOT NULL AUTO_INCREMENT,
    booking_id   INT      NOT NULL,
    sender_id    INT      NOT NULL,
    receiver_id  INT      NOT NULL,
    message_body TEXT     NOT NULL,
    sent_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_read      BOOLEAN  NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_message          PRIMARY KEY (message_id),
    CONSTRAINT fk_message_booking  FOREIGN KEY (booking_id)
        REFERENCES Booking(booking_id),
    CONSTRAINT fk_message_sender   FOREIGN KEY (sender_id)
        REFERENCES User(user_id),
    CONSTRAINT fk_message_receiver FOREIGN KEY (receiver_id)
        REFERENCES User(user_id)
);