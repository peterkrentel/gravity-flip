# 🎮 Gravity Flip

**A clip-first endless runner where failure is the feature.**

This is a 10-day experiment to build a viral mobile game focused on shareable death replays.

---

## 🚀 Quick Start

### 1. Open in Godot
1. Download **Godot 4.3** from https://godotengine.org/download/
2. Open Godot
3. Click **"Import"**
4. Navigate to this folder
5. Select `project.godot`
6. Click **"Import & Edit"**

### 2. Play the Game
- Press **F5** or click the ▶️ Play button
- **Tap/Click** to flip gravity
- Avoid obstacles
- Don't hit floor or ceiling

### 3. Test on Your Phone (Later)
- Go to **Project → Export**
- Follow Godot's Android export guide
- Or export to WebGL and upload to itch.io

---

## 🔪 Kill-Switch Checkpoints

### Day 3 Kill Check ⚠️
**Questions:**
- Does gravity flip feel good?
- Is the runner readable at speed?
- Is the death moment satisfying?

**If "meh" → STOP. Move on.**

### Day 7 Kill Check ⚠️
**Questions:**
- Does the replay look funny?
- Does slow-mo work?
- Does the death text land emotionally?

**If no one laughs → STOP. Ship nowhere.**

### Day 10 Kill Check ⚠️
**Questions:**
- Do YOU want to share your own fail?
- Does the clip explain the game in 2 seconds?

**If not → STOP. Don't publish.**

---

## 📁 Project Structure

```
gravity-flip/
├── project.godot          # Godot project config
├── scenes/
│   ├── main.tscn         # Single main scene (everything)
│   └── obstacle.tscn     # Obstacle prefab
├── scripts/
│   ├── game_state.gd     # State machine (Playing/Dying/Replaying/Share)
│   ├── runner.gd         # Player character + gravity flip
│   ├── replay_buffer.gd  # THE MOST IMPORTANT CLASS - records last 3s
│   ├── replay_player.gd  # Obstacle spawner (misnamed, will fix)
│   ├── obstacle.gd       # Obstacle behavior
│   └── game_ui.gd        # Timer + death overlay
└── icon.svg              # Placeholder icon
```

---

## 🎯 Core Philosophy

> **"You are not building a mobile game. You are building a failure replay engine with a game attached."**

If the replay isn't hilarious, nothing else matters.

---

## 💸 Hosting Strategy (Zero Cost)

1. **Android**: Google Play = $25 one-time ✅ Start here
2. **Web**: itch.io = FREE (for testing/viral spread)
3. **iOS**: $99/year (only if Android shows traction)

**No backend needed yet.** Everything runs client-side.

---

## 🛠️ Next Steps

- [ ] Get Godot installed
- [ ] Open project and hit Play
- [ ] Test gravity flip feel
- [ ] Add obstacle spawning (scene reference missing)
- [ ] Implement replay playback
- [ ] Add death text variants
- [ ] Export to Android/Web
- [ ] Test with real people

---

## 📝 Notes

- **Single scene architecture** - No menus, no loaders, no complexity
- **Replay is deterministic playback** - Not screen recording (saves battery)
- **Subscription FX layer** - Cosmetic only, zero gameplay coupling
- **Ads are dumb** - Interstitial after 2-3 deaths, never during replay

---

**License:** Apache 2.0 (see LICENSE)
