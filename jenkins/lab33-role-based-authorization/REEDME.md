# Lab 33: Role-based Authorization in Jenkins

This lab demonstrates how to implement **Role-Based Access Control (RBAC)** in Jenkins using the **Role-based Authorization Strategy** plugin.

## ✅ Objectives

- Create two users: `ivolve1` and `ivolve2`
- Assign:
  - **Admin role** to `ivolve1`
  - **Read-only role** to `ivolv2`

---

## 🛠️ Prerequisites

- Jenkins is installed and running
- Admin access to Jenkins UI

---

## 🔌 Step 1: Install the Role-based Authorization Plugin

1. Navigate to: `Manage Jenkins` → `Manage Plugins` → `Available`
2. Search for: `Role-based Authorization Strategy`
3. Install the plugin and restart Jenkins if required

---

## 🔐 Step 2: Enable Role-Based Strategy

1. Go to: `Manage Jenkins` → `Configure Global Security`
2. Under **Authorization**, choose: `Role-Based Strategy`
3. Save the configuration

---

## 👤 Step 3: Create Users

1. Navigate to: `Manage Jenkins` → `Manage Users` → `Create User`
2. Create:
   - `user1` with a password and email
   - `user2` with a password and email

![image]()
---

## 🧾 Step 4: Define Roles

1. Go to: `Manage Jenkins` → `Manage and Assign Roles` → `Manage Roles`
2. Under the **Global Roles** section:
   - Create a role named `admin` and check **all permissions**
   - Create a role named `read-only` and check only:
     - `Overall → Read`
     - `Job → Read`
3. Save changes

![image]()
---

## 📌 Step 5: Assign Roles to Users

1. Go to: `Manage and Assign Roles` → `Assign Roles`
2. Under **Global roles**, assign:
   - `admin` role to `user1`
   - `read-only` role to `user2`
3. Save the configuration

![image]()
---

## ✅ Verification

- Log in as `ivolve-1`: You should have full admin access
- Log in as `ivolve-2`: You should only be able to view jobs, not modify them

---

