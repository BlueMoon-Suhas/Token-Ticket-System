USE TICKETSYSTEM;

CREATE TABLE ticketsystem_status_T (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    color BIGINT NOT NULL
);

CREATE TABLE ticketsystem_priorities_T (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    color BIGINT NOT NULL
);

CREATE TABLE TicketSystem_users_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_admin BOOLEAN,
    ticket_agent BOOLEAN
);

CREATE TABLE TicketSystem_categories_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    color BIGINT
);

CREATE TABLE TicketSystem_MT (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(255),
    content TEXT,
    html TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    status_id INT,
    priority_id INT,
    user_id INT,
    agent_id INT,
    category_id INT,
    FOREIGN KEY (status_id) REFERENCES ticketsystem_status_T(id),
    FOREIGN KEY (priority_id) REFERENCES ticketsystem_priorities_T(id),
    FOREIGN KEY (user_id) REFERENCES TicketSystem_users_T(id),
    FOREIGN KEY (agent_id) REFERENCES TicketSystem_users_T(id),
    FOREIGN KEY (category_id) REFERENCES TicketSystem_categories_T(id)
);

CREATE TABLE TicketSystem_categories_users_T (
    category_id INT,
    user_id INT,
    FOREIGN KEY (category_id) REFERENCES TicketSystem_categories_T(id),
    FOREIGN KEY (user_id) REFERENCES TicketSystem_users_T(id)
);

CREATE TABLE TicketSystem_settings_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lang VARCHAR(50),
    slug VARCHAR(255),
    value MEDIUMTEXT,
    default_value MEDIUMTEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ticketsystem_comments_T(
    id INT PRIMARY KEY AUTO_INCREMENT,
    content LONGTEXT,
    user_id INT,
    ticket_id INT,
    created_at BIGINT,
    updated_at DATETIME,
    html LONGTEXT,
    FOREIGN KEY (user_id) REFERENCES TicketSystem_users_T(id),
    FOREIGN KEY (ticket_id) REFERENCES TicketSystem_MT(id)
);

CREATE TABLE TicketSystem_audits_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operation TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id INT,
    ticket_id INT,
    FOREIGN KEY (user_id) REFERENCES TicketSystem_users_T(id),
    FOREIGN KEY (ticket_id) REFERENCES TicketSystem_MT(id)
);

CREATE TABLE TicketSystem_attachments_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255),
    file_path VARCHAR(255),
    ticket_id INT,
    FOREIGN KEY (ticket_id) REFERENCES TicketSystem_MT(id)
);

CREATE TABLE TicketSystem_logs_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_message TEXT,
    user_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES TicketSystem_users_T(id)
);

CREATE TABLE TicketSystem_assignments_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT,
    assigned_to INT,
    assigned_by INT,
    assigned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES TicketSystem_MT(id),
    FOREIGN KEY (assigned_to) REFERENCES TicketSystem_users_T(id),
    FOREIGN KEY (assigned_by) REFERENCES TicketSystem_users_T(id)
);

CREATE TABLE TicketSystem_departments_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    department_head INT,
    FOREIGN KEY (department_head) REFERENCES TicketSystem_users_T(id)
);

CREATE TABLE TicketSystem_messages_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message_content TEXT,
    sender_id INT,
    receiver_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES TicketSystem_users_T(id),
    FOREIGN KEY (receiver_id) REFERENCES TicketSystem_users_T(id)
);

CREATE TABLE TicketSystem_subscribers_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT,
    subscriber_id INT,
    FOREIGN KEY (ticket_id) REFERENCES TicketSystem_MT(id),
    FOREIGN KEY (subscriber_id) REFERENCES TicketSystem_users_T(id)
);

CREATE TABLE TicketSystem_tags_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255),
    tag_color VARCHAR(7) DEFAULT '#000000'
);

CREATE TABLE TicketSystem_ticket_tags_T (
    ticket_id INT,
    tag_id INT,
    FOREIGN KEY (ticket_id) REFERENCES TicketSystem_MT(id),
    FOREIGN KEY (tag_id) REFERENCES TicketSystem_tags_T(id)
);

CREATE TABLE TicketSystem_priorities_settings_T (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT,
    priority_id INT,
    set_by_user_id INT,
    set_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES TicketSystem_MT(id),
    FOREIGN KEY (priority_id) REFERENCES ticketsystem_priorities_T(id),
    FOREIGN KEY (set_by_user_id) REFERENCES TicketSystem_users_T(id)
);

CREATE TABLE IF NOT EXISTS Agents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS AgentAssignmentCounter (
    counter INT NOT NULL
);





-- insertion of data 
INSERT INTO ticketsystem_status_T (name, color)
VALUES
    ('Open', 65280), -- Green
    ('In Progress', 16776960), -- Yellow
    ('Resolved', 255), -- Blue
    ('Closed', 16711680); -- Red

INSERT INTO ticketsystem_priorities_T (name, color)
VALUES
    ('Low', 16777215), -- White
    ('Medium', 16776960), -- Yellow
    ('High', 255), -- Blue
    ('Urgent', 16711680); -- Red 
    
INSERT INTO TicketSystem_settings_T (lang, slug, value, default_value)
VALUES
    ('en', 'site_title', 'Ticketing System', 'Ticketing System'), -- Site title settings
    ('en', 'site_description', 'A comprehensive ticketing solution for customer support.', 'A comprehensive ticketing solution for customer support.'), -- Site description settings
    ('en', 'admin_email', 'admin@example.com', 'admin@example.com'), -- Admin email settings
    ('en', 'timezone', 'UTC', 'UTC'), -- Timezone settings
    ('en', 'currency', 'USD', 'USD'); -- Currency settings

INSERT INTO TicketSystem_categories_T (name, color)
VALUES
    ('Category 1', 16711680), -- Red
    ('Category 2', 65280), -- Green
    ('Category 3', 255); -- Blue

INSERT INTO TicketSystem_users_T (ticket_admin, ticket_agent)
VALUES
    (1, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1),
    (0, 1);

INSERT INTO TicketSystem_tags_T (tag_name, tag_color)
VALUES
    ('Tag1', '#FF0000'),
    ('Tag2', '#00FF00'),
    ('Tag3', '#0000FF');

INSERT INTO TicketSystem_categories_users_T (category_id, user_id)
VALUES
    (1, 2),
    (2, 3),
    (1, 4),
    (3, 5),
    (2, 6);
    
INSERT INTO TicketSystem_logs_T (log_message, user_id)
VALUES
    ('User logged in successfully.', 2),
    ('Payment processing initiated.', 3),
    ('Bug fixed.', 1),
    ('Technical support provided.', 4),
    ('Service activated.', 2);
    
INSERT INTO TicketSystem_departments_T (name, department_head)
VALUES
    ('IT Support', 1),
    ('Customer Service', 2),
    ('Finance', 3),
    ('Sales', 4),
    ('Marketing', 5);
    
INSERT INTO TicketSystem_messages_T (message_content, sender_id, receiver_id)
VALUES
    ('Hello, how can I assist you today?', 1, 2),
    ('We have received your payment.', 2, 3),
    ('Bug report updated.', 3, 4),
    ('Software installation guide sent.', 4, 5),
    ('Thank you for your feedback.', 5, 1);

INSERT INTO TicketSystem_categories_users_T (category_id, user_id)
VALUES
    (1, 2),
    (2, 3),
    (1, 4),
    (3, 5),
    (2, 6);
DELETE FROM TicketSystem_categories_users_T;

Select * from TicketSystem_categories_users_T; 
SET sql_safe_updates = 0;

INSERT INTO TicketSystem_MT (subject, content, html, status_id, priority_id, user_id, agent_id, category_id)
VALUES
    ('Login Issue', 'Having trouble logging in, getting error messages.', '<p>Login issue description</p>', 1, 1, 2, 3, 1),
    ('Payment Problem', 'Encountering payment processing errors during checkout.', '<p>Payment issue details</p>', 3, 1, 3, 4, 2),
    ('Product Inquiry', 'Seeking information about product specifications.', '<p>Product inquiry content</p>', 3, 2, 1, 2, 1),
    ('Bug Report', 'Reporting a bug in the system, need immediate attention.', '<p>Bug report description</p>', 2, 4, 2, 1, 2),
    ('Service Request', 'Requesting service activation for a new subscription.', '<p>Service request details</p>', 1, 3, 3, 2, 3),
    ('Feedback Submission', 'Providing feedback on recent service interactions.', '<p>Feedback details</p>', 3, 3, 2, 3, 1),
    ('Account Update', 'Need to update account information for accuracy.', '<p>Account update details</p>', 2, 1, 4, 2, 2),
    ('Technical Support', 'Require technical assistance for software installation.', '<p>Tech support content</p>', 4, 2, 3, 1, 3),
    ('Order Status Inquiry', 'Checking the status of an order for delivery updates.', '<p>Order status details</p>', 3, 1, 3, 4, 1),
    ('Refund Request', 'Requesting a refund for a recent purchase.', '<p>Refund request details</p>', 1, 3, 2, 3, 2),
    ('Bug Report', 'Found another bug in the system, need assistance.', '<p>Second bug report description</p>', 4, 2, 1, 2, 3),
    ('Software Upgrade Request', 'Requesting an upgrade for software version.', '<p>Software upgrade details</p>', 3, 1, 3, 1, 2),
    ('Account Activation', 'Need assistance with account activation.', '<p>Account activation details</p>', 1, 1, 4, 3, 3),
    ('Feedback Submission', 'Providing additional feedback on service improvements.', '<p>Additional feedback details</p>', 4, 3, 2, 1, 1),
    ('Technical Support', 'Seeking technical support for system troubleshooting.', '<p>Second tech support content</p>', 3, 2, 1, 4, 2),
    ('Hardware Malfunction', 'Facing hardware malfunction, need repair.', '<p>Hardware issue details</p>', 1, 2, 3, 1, 3),
    ('Bug Report', 'Encountered a third bug, need urgent resolution.', '<p>Third bug report description</p>', 2, 1, 1, 3, 1),
    ('Payment Problem', 'Experiencing payment errors again, unable to complete transaction.', '<p>Second payment issue details</p>', 3, 3, 4, 2, 2),
    ('Login Issue', 'Still having login issues, unable to access account.', '<p>Second login issue description</p>', 1, 1, 2, 1, 3),
    ('Account Update', 'Need to update account information for recent changes.', '<p>Second account update details</p>', 2, 2, 3, 4, 1);

Select * from ticketsystem_mt;
DELETE FROM TicketSystem_mt;
ALTER TABLE TicketSystem_MT AUTO_INCREMENT = 1;

INSERT INTO TicketSystem_MT (subject, content, html, status_id, priority_id, user_id, agent_id, category_id)
VALUES
    ('Software Installation Issue', 'Encountering errors during software installation process.', '<p>Software installation issue details</p>', 1, 2, 4, 1, 3),
    ('Feature Request', 'Requesting new features to be added to the software.', '<p>Feature request description</p>', 3, 3, 1, 2, 2),
    ('Service Cancellation', 'Requesting cancellation of a service subscription.', '<p>Service cancellation details</p>', 2, 1, 3, 4, 3),
    ('Order Modification', 'Need to modify an existing order due to changes.', '<p>Order modification request details</p>', 3, 2, 2, 1, 1),
    ('Technical Training Request', 'Seeking technical training sessions for software usage.', '<p>Technical training request details</p>', 4, 3, 4, 2, 3),
    ('System Error Troubleshooting', 'Troubleshooting system errors and performance issues.', '<p>System error troubleshooting details</p>', 2, 4, 1, 3, 2),
    ('Data Migration Assistance', 'Requesting help with migrating data to a new system.', '<p>Data migration assistance details</p>', 1, 1, 2, 4, 1),
    ('Account Password Reset', 'Need assistance with resetting account password.', '<p>Password reset request details</p>', 3, 2, 3, 1, 3),
    ('Product Return Request', 'Initiating a request for product return and refund.', '<p>Product return request details</p>', 2, 3, 4, 2, 2),
    ('Software Update Issue', 'Facing issues with software update process, seeking resolution.', '<p>Software update issue details</p>', 4, 4, 1, 3, 1);
    
INSERT INTO TicketSystem_MT (subject, content, html, status_id, priority_id, user_id, agent_id, category_id)
VALUES
    ('Software Issue', 'Encountering software functionality issues, need resolution.', '<p>Software issue description</p>', 2, 2, 4, 3, 2),
    ('Feature Enhancement Request', 'Requesting enhancements to existing software features.', '<p>Feature enhancement request details</p>', 3, 3, 1, 2, 2),
    ('Service Renewal Request', 'Requesting renewal of service subscription.', '<p>Service renewal request details</p>', 1, 1, 3, 4, 3),
    ('Order Tracking Issue', 'Experiencing issues with order tracking system, seeking assistance.', '<p>Order tracking issue details</p>', 3, 2, 2, 1, 1),
    ('Training Session Request', 'Requesting training session for new system users.', '<p>Training session request details</p>', 4, 3, 4, 2, 3),
    ('Performance Optimization Request', 'Seeking optimization of software performance.', '<p>Performance optimization request details</p>', 2, 4, 1, 3, 2),
    ('Data Backup and Restore', 'Need assistance with data backup and restoration process.', '<p>Data backup and restore request details</p>', 1, 1, 2, 4, 1),
    ('Password Recovery Request', 'Requesting assistance with account password recovery.', '<p>Password recovery request details</p>', 3, 2, 3, 1, 3),
    ('Product Exchange Request', 'Initiating a request for product exchange.', '<p>Product exchange request details</p>', 2, 3, 4, 2, 2),
    ('System Update Issue', 'Facing issues with system update, need troubleshooting.', '<p>System update issue details</p>', 4, 4, 1, 3, 1);

INSERT INTO TicketSystem_MT (subject, content, html, status_id, priority_id, user_id, agent_id, category_id)
VALUES
    ('Software Issue', 'Encountering software functionality issues, need resolution.', '<p>Software issue description</p>', 2, 2, 4, 3, 2),
    ('Feature Enhancement Request', 'Requesting enhancements to existing software features.', '<p>Feature enhancement request details</p>', 3, 3, 1, 2, 2),
    ('Service Renewal Request', 'Requesting renewal of service subscription.', '<p>Service renewal request details</p>', 1, 1, 3, 4, 3),
    ('Order Tracking Issue', 'Experiencing issues with order tracking system, seeking assistance.', '<p>Order tracking issue details</p>', 3, 2, 2, 1, 1),
    ('Training Session Request', 'Requesting training session for new system users.', '<p>Training session request details</p>', 4, 3, 4, 2, 3),
    ('Performance Optimization Request', 'Seeking optimization of software performance.', '<p>Performance optimization request details</p>', 2, 4, 1, 3, 2),
    ('Data Backup and Restore', 'Need assistance with data backup and restoration process.', '<p>Data backup and restore request details</p>', 1, 1, 2, 4, 1),
    ('Password Recovery Request', 'Requesting assistance with account password recovery.', '<p>Password recovery request details</p>', 3, 2, 3, 1, 3),
    ('Product Exchange Request', 'Initiating a request for product exchange.', '<p>Product exchange request details</p>', 2, 3, 4, 2, 2),
    ('System Update Issue', 'Facing issues with system update, need troubleshooting.', '<p>System update issue details</p>', 4, 4, 1, 3, 1);

INSERT INTO TicketSystem_MT (subject, content, html, status_id, priority_id, user_id, agent_id, category_id)
VALUES
    ('Network Connectivity Issue', 'Experiencing network connection problems, unable to access services.', '<p>Network connectivity issue description</p>', 1, 2, 3, 1, 3),
    ('Feature Request', 'Requesting a new feature to improve user experience.', '<p>Feature request details</p>', 3, 3, 2, 4, 2),
    ('System Maintenance Inquiry', 'Inquiring about upcoming system maintenance schedule.', '<p>System maintenance inquiry details</p>', 3, 1, 1, 3, 1),
    ('File Upload Error', 'Encountering errors while uploading files, need assistance.', '<p>File upload error description</p>', 2, 4, 4, 2, 2),
    ('Software License Activation', 'Need help activating software licenses.', '<p>Software license activation details</p>', 1, 1, 3, 1, 3),
    ('Performance Issue', 'Experiencing slow system performance, seeking optimization.', '<p>Performance issue description</p>', 2, 2, 1, 4, 1),
    ('Data Recovery Request', 'Requesting data recovery assistance after accidental deletion.', '<p>Data recovery request details</p>', 4, 3, 2, 3, 2),
    ('Security Concern', 'Reporting a security issue that requires immediate attention.', '<p>Security concern details</p>', 3, 2, 4, 1, 2),
    ('Hardware Replacement Request', 'Requesting replacement of faulty hardware components.', '<p>Hardware replacement request details</p>', 1, 3, 3, 4, 3),
    ('System Update Inquiry', 'Inquiring about the latest system update and its features.', '<p>System update inquiry details</p>', 3, 1, 2, 1, 1);

Select * from ticketsystem_mt;

INSERT INTO TicketSystem_audits_T (operation, user_id, ticket_id)
VALUES
    ('Ticket created', 2, 1),
    ('Ticket updated', 3, 1),
    ('Ticket assigned', 4, 1),
    ('Ticket status changed', 1, 2),
    ('Ticket assigned', 2, 2),
    ('Ticket updated', 3, 3),
    ('Ticket status changed', 4, 3),
    ('Ticket created', 1, 4),
    ('Ticket assigned', 2, 4),
    ('Ticket updated', 3, 4);
    
INSERT INTO TicketSystem_subscribers_T (ticket_id, subscriber_id)
VALUES
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 1);
    
INSERT INTO TicketSystem_priorities_settings_T (ticket_id, priority_id, set_by_user_id)
VALUES
    (1, 1, 2),
    (2, 2, 3),
    (3, 3, 4),
    (4, 4, 1),
    (5, 1, 2);
    
INSERT INTO TicketSystem_assignments_T (ticket_id, assigned_to, assigned_by, assigned_at)
VALUES
    (1, 2, 1, NOW()),
    (2, 1, 3, NOW()),
    (3, 4, 2, NOW()),
    (4, 3, 1, NOW()),
    (5, 2, 3, NOW()),
    (6, 1, 4, NOW()),
    (7, 4, 3, NOW()),
    (8, 3, 2, NOW()),
    (9, 2, 1, NOW()),
    (10, 1, 4, NOW());
    
INSERT INTO TicketSystem_attachments_T (file_name, file_path, ticket_id)
VALUES
    ('attachment1.pdf', '/path/to/attachment1.pdf', 1),
    ('attachment2.jpg', '/path/to/attachment2.jpg', 2),
    ('attachment3.docx', '/path/to/attachment3.docx', 3),
    ('attachment4.txt', '/path/to/attachment4.txt', 4),
    ('attachment5.zip', '/path/to/attachment5.zip', 5);
    
INSERT INTO ticketsystem_comments_T (content, user_id, ticket_id, created_at, updated_at, html)
VALUES
    ('Experiencing issues with login. Could you please check?', 2, 1, UNIX_TIMESTAMP(), NOW(), '<p>Experiencing issues with login. Could you please check?</p>'),
    ('Thank you for reaching out. We are looking into it.', 3, 1, UNIX_TIMESTAMP(), NOW(), '<p>Thank you for reaching out. We are looking into it.</p>'),
    ('Let me assist you with that. Could you provide more details?', 1, 2, UNIX_TIMESTAMP(), NOW(), '<p>Let me assist you with that. Could you provide more details?</p>'),
    ('We apologize for the inconvenience. Our team is working on it.', 4, 3, UNIX_TIMESTAMP(), NOW(), '<p>We apologize for the inconvenience. Our team is working on it.</p>'),
    ('We will resolve this issue promptly. Thank you for reporting.', 2, 4, UNIX_TIMESTAMP(), NOW(), '<p>We will resolve this issue promptly. Thank you for reporting.</p>'),
    ('We appreciate your feedback. Our team will review it.', 3, 5, UNIX_TIMESTAMP(), NOW(), '<p>We appreciate your feedback. Our team will review it.</p>'),
    ('Let us schedule a call to discuss this further.', 1, 6, UNIX_TIMESTAMP(), NOW(), '<p>Let us schedule a call to discuss this further.</p>'),
    ('I will check this and get back to you shortly.', 4, 7, UNIX_TIMESTAMP(), NOW(), '<p>I will check this and get back to you shortly.</p>'),
    ('We understand your concern. Our team is investigating.', 2, 8, UNIX_TIMESTAMP(), NOW(), '<p>We understand your concern. Our team is investigating.</p>'),
    ('We will keep you updated on the progress. Thank you.', 3, 9, UNIX_TIMESTAMP(), NOW(), '<p>We will keep you updated on the progress. Thank you.</p>'),
    ('We apologize for any inconvenience caused.', 1, 10, UNIX_TIMESTAMP(), NOW(), '<p>We apologize for any inconvenience caused.</p>'),
    ('We are working on fixing this. Thank you for your patience.', 4, 11, UNIX_TIMESTAMP(), NOW(), '<p>We are working on fixing this. Thank you for your patience.</p>'),
    ('Thank you for bringing this to our attention.', 2, 12, UNIX_TIMESTAMP(), NOW(), '<p>Thank you for bringing this to our attention.</p>'),
    ('We will ensure this is resolved promptly. Thank you for your understanding.', 3, 13, UNIX_TIMESTAMP(), NOW(), '<p>We will ensure this is resolved promptly. Thank you for your understanding.</p>'),
    ('Your feedback helps us improve our services. Thank you.', 1, 14, UNIX_TIMESTAMP(), NOW(), '<p>Your feedback helps us improve our services. Thank you.</p>'),
    ('We will keep you updated on the status. Thank you for your cooperation.', 4, 15, UNIX_TIMESTAMP(), NOW(), '<p>We will keep you updated on the status. Thank you for your cooperation.</p>'),
    ('We will address this issue and provide a solution shortly.', 2, 16, UNIX_TIMESTAMP(), NOW(), '<p>We will address this issue and provide a solution shortly.</p>'),
    ('We appreciate your patience as we resolve this issue.', 3, 17, UNIX_TIMESTAMP(), NOW(), '<p>We appreciate your patience as we resolve this issue.</p>'),
    ('We apologize for any inconvenience caused. Our team will assist you.', 1, 18, UNIX_TIMESTAMP(), NOW(), '<p>We apologize for any inconvenience caused. Our team will assist you.</p>'),
    ('Thank you for your understanding. We are actively working on it.', 4, 19, UNIX_TIMESTAMP(), NOW(), '<p>Thank you for your understanding. We are actively working on it.</p>');

Select * from ticketsystem_ticket_tags_T;

INSERT INTO TicketSystem_ticket_tags_T (ticket_id, tag_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 1),
    (5, 2);
    
-- TRIGGERS--

#1 AUDITLOG TRIGGER

DELIMITER $$

CREATE TRIGGER AuditLogTrigger
AFTER UPDATE ON TicketSystem_MT
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog(ticket_id, column_name, old_value, new_value, changed_at)
    VALUES(NEW.id, 'status_id', OLD.status_id, NEW.status_id, NOW());
    -- Note: This example assumes changes to 'status_id'. You may need to replicate or adapt for other columns.
END$$

DELIMITER ;

#2 Notification Trigger


DELIMITER $$

CREATE TRIGGER NotificationTrigger
AFTER UPDATE ON TicketSystem_MT
FOR EACH ROW
BEGIN
    IF OLD.status_id != NEW.status_id AND NEW.status_id = 3 THEN -- Assuming 3 means completed
        CALL SendNotification(NEW.user_id, 'Your ticket has been completed.', NEW.id);
        -- `SendNotification` must be a defined PROCEDURE in your database that handles the notification logic.
    END IF;
END$$

DELIMITER ;


#3 Agent Assignment Trigger

DELIMITER $$

CREATE TRIGGER AgentAssignmentTrigger
BEFORE INSERT ON TicketSystem_MT
FOR EACH ROW
BEGIN
    DECLARE totalAgents INT DEFAULT 0;
    DECLARE currentCounter INT DEFAULT 0;
    DECLARE agentIds INT;
    DECLARE rowCount INT DEFAULT 0;

    -- Initialize counter if no entry exists
    SELECT COUNT(*) INTO rowCount FROM AgentAssignmentCounter;
    IF rowCount = 0 THEN
        INSERT INTO AgentAssignmentCounter (counter) VALUES (0);
        SET currentCounter = 0;
    ELSE
        SELECT counter INTO currentCounter FROM AgentAssignmentCounter ORDER BY counter DESC LIMIT 1;
    END IF;

    -- Get total number of agents
    SELECT COUNT(*) INTO totalAgents FROM Agents;
    IF totalAgents > 0 THEN
        -- Calculate next agent's ID. Note: MySQL does not support OFFSET in SET/SELECT INTO directly.
        -- So, we get the ID of the agent based on ordering and limiting the result set.
        SET agentIds = currentCounter % totalAgents;
        SET NEW.agent_id = (SELECT id FROM Agents ORDER BY id LIMIT 1 OFFSET agentIds);

        -- Update the counter for the next operation
        UPDATE AgentAssignmentCounter SET counter = currentCounter + 1;
    ELSE
        -- If no agents are available, you might want to handle this case differently.
        SET NEW.agent_id = NULL;
    END IF;
END$$

DELIMITER ;x`

# completion time stamp trigger 


DELIMITER $$

CREATE TRIGGER UpdateCompletionTimestamp
AFTER UPDATE ON TicketSystem_MT
FOR EACH ROW
BEGIN
    IF OLD.status_id != NEW.status_id AND NEW.status_id = 3 THEN
        -- Assuming `status_id` = 3 indicates the ticket is completed
        UPDATE TicketSystem_MT SET completed_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
    END IF;
END$$

DELIMITER ;




