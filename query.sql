CREATE DATABASE IF NOT EXISTS  library ;

    CREATE TABLE books (
    id INT primary KEY AUTO_INCREMENT ,
    title varchar(60) NOT null ,
    author varchar(80) NOT null ,
    published_year INT NOT null ,
    available_copies INT default 0
    );

    CREATE TABLE members(
    id INT primary KEY AUTO_INCREMENT ,
    name varchar(80) NOT null ,
    email varchar(150) NOT null ,
    join_date date
    );

    CREATE TABLE borrowings(
    id INT primary KEY AUTO_INCREMENT ,
    member_id INT ,
    book_id INT ,
    borrow_date date , 
    return_date date ,
    foreign KEY(book_id) references books(id) ,
    foreign KEY(member_id) references members(id)
    );

INSERT INTO books (title, author, published_year, available_copies) 
VALUES 
('Maha Kavithai', 'Vairamuthu', 1995, 5),
('A Life in Three Campaigns', 'M.J. Akbar and K Natwar Singh', 1999, 2),
('Pagalkhana', 'Dr.Gyan Chaturvedi', 2001, 4),
('To Kill a Mockingbird', 'Harper Lee', 1960, 6),
('Snakes in the Ganga', 'Anurag Behar', 2004, 3);

INSERT INTO members (name, email, join_date) 
VALUES 
('Menna', 'menna@example.com', '2004-12-23'),
('Jana', 'jana@example.com', '2007-03-10'),
('Noran', 'noran@example.com', '2009-03-10'),
('Tala', 'tala@example.com', '2018-04-01'),
('Mona', 'mona@example.com', '2023-05-20');

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date) 
VALUES 
(1, 2, '2025-06-01', '2025-06-15'),
(2, 1, '2025-08-10', '2025-08-20'),
(3, 4, '2025-06-10', '2025-06-25'),
(4, 3, '2025-06-12', '2025-06-22'),
(5, 5, '2025-07-15', '2025-07-30');

-- Show all borrowed books with member names
SELECT books.title, books.author, members.name
FROM borrowings 
JOIN books ON borrowings.book_id = books.id
JOIN members ON borrowings.member_id = members.id;

--  Count how many books each member has borrowed
SELECT count(member_id)as total , members.name FROM `borrowings`
join members
on borrowings.member_id = members.id
GROUP BY member_id;

-- Show books that were borrowed in the last 30 days
SELECT books.title, borrowings.borrow_date, borrowings.return_date
FROM borrowings
JOIN books ON borrowings.book_id = books.id
WHERE borrowings.borrow_date >= CURDATE() - INTERVAL 30 DAY;