
-- =============================================================================
-- TEST QUERIES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Test 1: Booking Management
-- Show all bookings with guest name, listing title, dates, price, and status.
-- -----------------------------------------------------------------------------
SELECT
    b.booking_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    l.title                                AS listing_title,
    l.city,
    b.check_in_date,
    b.check_out_date,
    DATEDIFF(b.check_out_date, b.check_in_date) AS nights,
    b.total_price,
    b.status
FROM Booking b
JOIN User    u ON b.guest_id   = u.user_id
JOIN Listing l ON b.listing_id = l.listing_id
ORDER BY b.created_at DESC;

-- -----------------------------------------------------------------------------
-- Test 2: Availability Check
-- Find all listings available on a specific date that can accommodate 2+ guests.
-- -----------------------------------------------------------------------------
SELECT
    l.listing_id,
    l.title,
    l.city,
    l.price_per_night,
    COALESCE(a.price_override, l.price_per_night) AS effective_price,
    l.max_guests
FROM Listing      l
JOIN Availability a ON l.listing_id = a.listing_id
WHERE a.date         = '2025-07-01'
  AND a.is_available = TRUE
  AND l.max_guests  >= 2
  AND l.is_active    = TRUE
ORDER BY effective_price ASC;

-- -----------------------------------------------------------------------------
-- Test 3: Payment and Revenue Report
-- Show total revenue per listing, broken down by booking count and service fees.
-- -----------------------------------------------------------------------------
SELECT
    l.listing_id,
    l.title,
    l.city,
    CONCAT(u.first_name, ' ', u.last_name) AS host_name,
    COUNT(b.booking_id)                    AS total_bookings,
    SUM(b.total_price)                     AS gross_revenue,
    SUM(b.service_fee)                     AS total_service_fees,
    SUM(b.total_price - b.service_fee)     AS host_revenue_after_commission
FROM Listing l
JOIN User    u ON l.host_id    = u.user_id
JOIN Booking b ON l.listing_id = b.listing_id
WHERE b.status IN ('Completed', 'Confirmed')
GROUP BY l.listing_id, l.title, l.city, u.first_name, u.last_name
ORDER BY gross_revenue DESC;

-- -----------------------------------------------------------------------------
-- Test 4: Reviews and Average Ratings
-- Show each host's average guest rating and total number of reviews received.
-- -----------------------------------------------------------------------------
SELECT
    CONCAT(u.first_name, ' ', u.last_name) AS host_name,
    COUNT(r.review_id)                     AS total_reviews,
    ROUND(AVG(r.rating), 2)               AS average_rating
FROM User   u
JOIN Review r ON r.reviewee_id = u.user_id
WHERE u.role        = 'Host'
  AND r.review_type = 'guest_review'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY average_rating DESC;

-- -----------------------------------------------------------------------------
-- Test 5: Host Income Estimator
-- Calculate estimated monthly earnings per host based on confirmed/completed
-- bookings, showing gross earnings and net after platform commission.
-- -----------------------------------------------------------------------------
SELECT
    CONCAT(u.first_name, ' ', u.last_name) AS host_name,
    COUNT(b.booking_id)                    AS completed_bookings,
    SUM(b.total_price - b.service_fee)     AS gross_host_earnings,
    SUM(p.host_fee_deducted)               AS total_commission_paid,
    SUM(p.amount)                          AS net_payout
FROM User    u
JOIN Listing l  ON l.host_id    = u.user_id
JOIN Booking b  ON b.listing_id = l.listing_id
JOIN Payout  p  ON p.booking_id = b.booking_id
WHERE u.role   = 'Host'
  AND b.status IN ('Completed', 'Confirmed')
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY net_payout DESC;

-- -----------------------------------------------------------------------------
-- Test 6: Unread Messages per User
-- Show all users who have unread messages and how many.
-- -----------------------------------------------------------------------------
SELECT
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.role,
    COUNT(m.message_id)                    AS unread_messages
FROM User    u
JOIN Message m ON m.receiver_id = u.user_id
WHERE m.is_read = FALSE
GROUP BY u.user_id, u.first_name, u.last_name, u.role
ORDER BY unread_messages DESC;

-- -----------------------------------------------------------------------------
-- Test 7: Most Wishlisted Listings
-- Show which listings appear in the most wishlists.
-- -----------------------------------------------------------------------------
SELECT
    l.listing_id,
    l.title,
    l.city,
    l.price_per_night,
    COUNT(wi.wishlist_id) AS times_wishlisted
FROM Listing      l
JOIN WishlistItem wi ON l.listing_id = wi.listing_id
GROUP BY l.listing_id, l.title, l.city, l.price_per_night
ORDER BY times_wishlisted DESC;

-- -----------------------------------------------------------------------------
-- Test 8: Open Reports Summary
-- Show all open disputes with reporter, reported user, and listing.
-- -----------------------------------------------------------------------------
SELECT
    rep.report_id,
    CONCAT(u1.first_name, ' ', u1.last_name) AS reporter,
    CONCAT(u2.first_name, ' ', u2.last_name) AS reported_user,
    l.title                                  AS listing_involved,
    rep.status,
    rep.created_at
FROM Report  rep
JOIN User    u1 ON rep.reporter_id      = u1.user_id
JOIN User    u2 ON rep.reported_user_id = u2.user_id
LEFT JOIN Listing l ON rep.listing_id   = l.listing_id
WHERE rep.status = 'Open'
ORDER BY rep.created_at ASC;