# 🛠️ Class 2: App State and Data Persistance

**Goal:** Save the data from the app in User Defaults

---

## 🗺️ Implementation Roadmap

> Order to fo files:

1. TaskModels
2. Content View
3. GroupStatsView
4. TaskGroupDetailView

### The App Lifecycle (`scenePhase`)
Apps on iOS have different "states". We use `@Environment(\.scenePhase)` to listen for these changes.

| Phase | Meaning | Ideal Action |
| :--- | :--- | :--- |
| **.active** | App is on screen and interactive. | Resume animations/timers. |
| **.inactive** | App is on screen but not interactive (e.g., Notification Center pulled down). | Pause games/audio. |
| **.background** | App is not visible. | **SAVE DATA HERE.** |
