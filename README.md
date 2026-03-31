# Doodle: Postpartum Care & Bridging the Gap

An "Elite Dribbble-tier" postpartum recovery aid that translates Mother's logs into actionable partner tasks.

---

## 🚀 Quick Setup

### 📱 Frontend (Flutter)
1. Ensure the Flutter SDK is installed.
2. From the root directory:
   ```bash
   flutter pub get
   ```
3. Launch on your emulator or device:
   ```bash
   flutter run
   ```

### ⚙️ Backend (Node/Express)
1. Ensure Node.js and MongoDB are installed.
2. Navigate to the server folder:
   ```bash
   cd server
   npm install
   ```
3. Create a `.env` in the `server/` directory:
   ```env
   PORT=5000
   MONGODB_URI=mongodb://localhost:27017/doodle
   ```
4. Start the server:
   ```bash
   node index.js
   ```

---

## 📂 Project Architecture

### **Frontend (`lib/`)**
- **`screens/`**: High-fidelity UI (Logger, Care Hub, Mother/Partner Dashboards).
- **`providers/`**: Real-time state synchronization via `ChangeNotifier`.
- **`theme/`**: Centralized visual language (Cream, Lavender, Pink palette).

### **Backend (`server/`)**
- **`models/`**: Mongoose schemas (User, SymptomLog, ActionTask).
- **`index.js`**: Core API and "So What" Translation Engine logic.

---

## 🎨 Visual Identity
- **Background**: Soft Cream (`0xFFFDFBF7`)
- **Primary**: Dark Lavender (`0xFF6B5B95`)
- **Secondary**: Soft Baby Pink (`0xFFFDF0F3`)
- **Font**: GoogleFonts.poppins
