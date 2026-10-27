# FloodSight — Satellite-Based Flood Extent Intelligence & Response Planning System

**Team:** TeamPhoenix  
**Status:** GitHub-Ready / Production-Grade Local Architecture  
**License:** [MIT](LICENSE)

---

## 🌊 Overview

**FloodSight** is an emergency-management geospatial intelligence dashboard and triage decision-support application developed by **TeamPhoenix**. During major flood disasters, relief agencies, civil protection coordinators, and humanitarian dispatchers require fast, evidence-grounded spatial insights. 

FloodSight bridges the gap between **earth observation satellite data catalogues** and **critical ground infrastructure** by:
1. Exploring verified flood inundation polygons.
2. Calculating exact **WGS84 ellipsoidal geodesic surface areas** without naive degree distortions.
3. Performing geometric intersection clipping against roads, building footprints, and civic facilities.
4. Triaging geographic sectors using an **explainable multi-factor scoring rubric** (0–100) with complete factor transparency.
5. Providing an honest distinction between **synthetic demo scenarios**, **catalogue metadata**, **processed imagery**, and **ground-truth damage**.

---

## 🛰️ Architecture & Technology Stack

FloodSight is architected as a lightweight, robust monorepo:

```
FloodSight-TeamPhoenix/
├── backend/
│   ├── app/
│   │   ├── api/                  # FastAPI routers (sources, geospatial, priority, reports)
│   │   ├── services/             # Geodesic calculator, OSM Overpass, CDSE, Zenodo, EMS
│   │   ├── data/                 # Synthetic offline demonstration scenario
│   │   ├── config.py             # App environment configuration & CORS
│   │   └── main.py               # FastAPI entrypoint & middleware
│   ├── tests/                    # 20 pytest test suites (geodesics, APIs, priority)
│   ├── requirements.txt          # Python dependencies (FastAPI, Shapely, httpx, pytest)
│   └── pytest.ini
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── common/           # DemoBadge, StatusBadge, KpiCard, AlertBanner, Modal
│   │   │   ├── layout/           # Sidebar, Topbar, AppLayout
│   │   │   └── map/              # Leaflet InteractiveMap, MapLegend, LayerControl
│   │   ├── context/              # AppContext (Demo/Live state), SourcesContext (Registry)
│   │   ├── pages/                # Overview, FloodMap, Sources, Impact, Priority, Reports, Methodology, Settings
│   │   ├── services/             # API client & offline fallback demo scenario
│   │   ├── utils/                # Geodesic calculations & GeoJSON bounds validator
│   │   ├── App.jsx & main.jsx
│   │   └── index.css             # Tailwind CSS & Leaflet theme
│   ├── package.json
│   ├── tailwind.config.js
│   ├── vitest.config.js
│   └── src/test/                 # 19 Vitest tests (geodesics, validation, navigation)
├── .env.example                  # Safe template for credentials
├── .gitignore                    # Excludes venv, node_modules, keys, caches, large rasters
├── run-backend.bat / .ps1        # One-click Windows backend launcher
├── run-frontend.bat / .ps1       # One-click Windows frontend launcher
├── run-tests.bat / .ps1          # One-click full test suite execution
├── LICENSE                       # MIT License
└── README.md
```

### Stack Components:
- **Frontend:** React 19 + Vite 8 + Tailwind CSS 3 (Dark Slate/Navy Theme)
- **Map Engine:** Leaflet 1.9 with OpenStreetMap and CartoDB Dark Matter basemaps
- **Analytics Charts:** Recharts
- **Icons:** Lucide React
- **Backend API:** Python 3.10+ / 3.14 + FastAPI + Pydantic v2 + HTTPX (Async)
- **Geospatial Processing:** WGS84 Geodesic Ellipsoidal Engine (Chamberlain-Duquette spherical excess) + Shapely 2.0 (Vector clipping & intersection)
- **Test Suites:** Vitest (Frontend) + Pytest & Pytest-Asyncio (Backend)

---

## ✨ Key Features

### 1. Interactive Geospatial Command Map
- Render verified flood boundaries, roads, buildings, and critical facilities.
- Switch between **CartoDB Dark Matter** and **OpenStreetMap Standard** tiles.
- Vector layer toggles with custom symbology, tooltips, and click-to-inspect flyout.
- Bounding box reset control and interactive point coordinate inspector.

### 2. External Data Source Registry (5 Sources)
- **Copernicus CDSE Sentinel-1 (SAR):** C-Band SAR radar catalogue search via official OData API.
- **Copernicus CDSE Sentinel-2 (MSI):** Optical multispectral catalogue search with cloud-cover filtering.
- **Copernicus EMS Rapid Mapping:** Official European Commission emergency activation portal metadata.
- **STURM-Flood Benchmark (Zenodo 12748983):** Inundation dataset metadata & tile sizes (no multi-GB auto-downloads).
- **OpenStreetMap Overpass API:** Live queries for roads (`highway`), structures (`building`), and critical amenities (`hospital`, `school`, `fire_station`).
- Per-source health badges (`Connected`, `No matching records`, `Rate limited`, `Unavailable`, `Error`), retry buttons, and refresh all.

### 3. Geodesic Surface Analysis & Vector Clipping
- Accurate **WGS84 ellipsoidal geodesic area** in square kilometers and hectares.
- Geometrically clips intersecting road LineStrings; only the submerged length is counted.
- Identifies critical civic facilities (hospitals, schools, evacuation shelters) inside the water boundary.

### 4. Explainable Priority Review Rubric
- 0–100 point triage scoring across 4 weighted transparent factors:
  - **Critical Facilities Presence:** Up to 35 pts
  - **Transport Network Severance:** Up to 25 pts
  - **Building Exposure Density:** Up to 25 pts
  - **Inundation Extent Coverage:** Up to 15 pts
- Explicit evidence completeness ratings (`HIGH`, `MEDIUM`, `LOW`).
- Human reviewer workflow: `Unreviewed`, `Needs verification`, `Verified in field`, `Dismissed`.

### 5. Multi-Format Reports & Print View
- Standardized CSV export with legal/methodology disclaimers and bounding box.
- Structured JSON export for integration into broader GIS or incident command pipelines.
- Browser print view (`window.print()`) formatted cleanly for emergency briefings.

### 6. Offline-Friendly Demo Mode
- Instant access to the **Aethelgard River Basin** synthetic test scenario without API keys or internet access.
- Every metric, chart, and export in demo mode is explicitly labelled **`[DEMO MODE]`**.
- One-click toggle between Demo and Live Mode, plus a scenario reset action.

---

## 📋 Prerequisites

- **Windows 10 / 11** (or Linux / macOS)
- **Node.js:** v18.0.0 or higher (`node -v`)
- **Python:** v3.10 or higher (`python --version`)

---

## 🚀 Quick Start Guide (Windows)

### Option A: Using Launcher Scripts (Easiest)

1. Open PowerShell or Command Prompt in the project folder:
   ```powershell
   # 1. Run the Backend (Terminal 1)
   .\run-backend.ps1
   # (or run-backend.bat in Command Prompt)

   # 2. Run the Frontend (Terminal 2)
   .\run-frontend.ps1
   # (or run-frontend.bat in Command Prompt)
   ```
2. Open your browser at **`http://localhost:5173`**.

---

### Option B: Manual Setup

#### Step 1: Backend Installation & Run
```powershell
# Create Python virtual environment
python -m venv backend/venv

# Activate virtual environment
# In PowerShell:
.\backend\venv\Scripts\Activate.ps1
# In Command Prompt:
.\backend\venv\Scripts\activate.bat

# Install dependencies
python -m pip install -r backend/requirements.txt

# Start FastAPI server
$env:PYTHONPATH="backend"
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
```
*Backend API will be active at `http://127.0.0.1:8000` with Swagger documentation at `http://127.0.0.1:8000/api/docs`.*

#### Step 2: Frontend Installation & Run
In a separate terminal window:
```powershell
cd frontend

# Install Node dependencies
npm.cmd install

# Start Vite dev server
npm.cmd run dev
```
*Frontend will open at `http://localhost:5173`.*

---

## 🧪 Running Tests & Production Build

### Running Full Test Suite
Both backend and frontend have comprehensive test coverage:

```powershell
# Using the unified script:
.\run-tests.ps1
# (or run-tests.bat in Command Prompt)
```

#### Individual Backend Tests (Pytest)
```powershell
$env:PYTHONPATH="backend"
.\backend\venv\Scripts\python.exe -m pytest backend -v
```
*Result: 20 passed tests across API routes, geodesic math, and priority scoring.*

#### Individual Frontend Tests (Vitest)
```powershell
cd frontend
npm.cmd test
```
*Result: 19 passed tests across geodesics, GeoJSON validation, and UI navigation.*

#### Production Build Verification
```powershell
cd frontend
npm.cmd run build
```
*Produces optimized bundle in `frontend/dist/`.*

---

## 🔑 Environment Configuration (`.env`)

Copy `.env.example` to `.env` in the root or set in backend:
```ini
# FastAPI Settings
FLOODSIGHT_HOST=127.0.0.1
FLOODSIGHT_PORT=8000
FLOODSIGHT_CORS_ORIGINS=http://localhost:5173,http://127.0.0.1:5173

# OpenStreetMap Overpass Endpoint
OVERPASS_API_URL=https://overpass-api.de/api/interpreter
OVERPASS_TIMEOUT_SECONDS=25

# Zenodo STURM-Flood
ZENODO_API_URL=https://zenodo.org/api/records/12748983

# Copernicus Data Space Ecosystem (Optional for metadata search)
# Register free at https://dataspace.copernicus.eu/
COPERNICUS_CDSE_CLIENT_ID=your_id_here
COPERNICUS_CDSE_CLIENT_SECRET=your_secret_here

# Frontend
VITE_API_BASE_URL=http://127.0.0.1:8000/api
```

> **Important:** FloodSight search works **completely without paid API keys**. CDSE metadata, Zenodo STURM-Flood records, and OSM Overpass queries use official open access endpoints.

---

## 🔬 Scientific Methodology & Radar Limitations

### SAR Flood Detection Principle
Sentinel-1 SAR operates at C-band (5.405 GHz). Calm surface water exhibits **specular reflection**, directing radar energy away from the sensor. Water pixels appear with low backscatter values (typically &lt; -16 dB).

### Documented Physics Limitations
1. **Surface Roughness:** Strong storm winds cause capillary waves on water bodies, increasing backscatter and causing false negatives.
2. **Urban Double-Bounce:** Microwave pulses bounce between flooded streets and vertical building facades, masking submerged roads.
3. **Vegetation Canopy:** Emergent crops or flooded forests obscure C-band radar; L-band or interferometric coherence is required.
4. **Radar Shadow:** Mountainous terrain mimics dark water signatures without precise digital elevation model (DEM) radiometric terrain correction.
5. **Permanent Water:** Permanent rivers and lakes must be subtracted using reference surface water masks before calculating temporary inundation.

---

## ⚠️ Known Limitations & Future Roadmap

- **Raster Processing:** Raw Sentinel-1 GRD SAR raster calibration requires heavy GDAL/SNAP workflows and large disk space (~1 GB per granule). FloodSight focuses on catalogue discovery and vector boundary verification. Future work can integrate cloud-native Earth Engine / STAC pipelines.
- **Model Predictions:** We do not claim to run neural networks or U-Net flood inference; future versions can plug into trained ONNX segmentation runtimes.
- **Exposure vs Damage:** 2D spatial intersection does not confirm structural failure or road impassability without on-site ground truth.

---

## 📦 How to Publish to GitHub

When ready to publish to a remote repository, follow these steps:

1. **Verify Git status and ensure no secrets or large datasets are staged:**
   ```powershell
   git status
   ```
2. **Initialize Git (if not already done) and commit:**
   ```powershell
   git init
   git add .
   git commit -m "feat: complete FloodSight satellite flood intelligence system"
   ```
3. **Link to your GitHub repository:**
   ```powershell
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/FloodSight-TeamPhoenix.git
   git push -u origin main
   ```
*(Do not commit `.env` or large `.tif` imagery files — already safeguarded in `.gitignore`)*

---

## 👥 Team & Acknowledgments

- **Developed by:** TeamPhoenix
- **Data Attributions:**
  - OpenStreetMap &copy; OpenStreetMap contributors (ODbL)
  - Copernicus Data Space Ecosystem (ESA / European Commission)
  - STURM-Flood Dataset (Zenodo 12748983, CC-BY 4.0)
  - CartoDB Dark Matter basemap &copy; CARTO
- **License:** [MIT License](LICENSE)
