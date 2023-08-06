# Бизнес события

## Task.AssigneeChanged
Producer: Task management Domain

Consumer: Accounting Domain
## Task.StatusChanged
Producer: Task management Domain

Consumer: Accounting Domain

# CUD события
## Account.CUD
Producer: Auth Domain

Consumer:
- Task management Domain
- Accounting Domain

Data:
- ID
- Name
- Role etc

## Task.Created
Producer: Task management Domain

Consumer:
- Accounting Domain
- Analytics Domain

Data:
- Description
- Status
- Assignee
- Cost
- Reward

## AuditLog.Created
Producer: Accounting Domain

Consumer: Analytics Domain

Data:
- User ID
- Task ID
- Amount
