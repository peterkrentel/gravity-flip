# 🚀 Getting Started - First 5 Minutes

## Step 1: Download Godot (2 minutes)

**Mac:**
1. Go to: https://godotengine.org/download/macos/
2. Click the blue **"Godot Engine 4.3 - Standard"** button
3. Wait for download to finish
4. Drag `Godot.app` to your Applications folder
5. Double-click to open

**First time opening:**
- macOS will say "unidentified developer"
- Right-click Godot.app → Open → Confirm
- This is normal for open-source apps

---

## Step 2: Open This Project (1 minute)

1. Godot opens → you see the Project Manager
2. Click **"Import"** button
3. Click **"Browse"**
4. Navigate to `/Users/peterkrentel/repos/gravity-flip`
5. Select the `project.godot` file
6. Click **"Import & Edit"**

---

## Step 3: Play the Game (30 seconds)

1. Press **F5** (or click the ▶️ Play button in top-right)
2. Game window opens
3. **Click or tap** anywhere to flip gravity
4. Try to survive!

**Controls:**
- **Mouse click** or **tap** = flip gravity
- **Escape** = quit

---

## What You Should See

✅ A blue square (the runner) moving right  
✅ Gray floor at bottom, gray ceiling at top  
✅ Timer counting up in top-center  
✅ When you click → gravity flips  
✅ When you hit floor/ceiling → death overlay appears  

---

## Troubleshooting

**"I don't see anything when I press Play"**
- Check the Output panel at bottom of Godot
- Look for error messages in red

**"The runner falls through the floor"**
- This is a collision layer issue
- We'll fix this in the next iteration

**"No obstacles appear"**
- This is expected! Obstacle spawning needs one more fix
- The core gravity flip mechanic should work

---

## Next Steps

Once you can flip gravity and die:

1. **Test the feel** - Does flipping gravity feel responsive?
2. **Check the death** - Is the death moment satisfying?
3. **Report back** - Tell me what works and what doesn't

Then we'll add:
- Obstacles that actually spawn
- Replay playback
- Death text variants
- Polish

---

## Quick Reference

**Run game:** F5  
**Stop game:** F8  
**Edit scene:** Click `scenes/main.tscn` in FileSystem panel  
**Edit script:** Click any `.gd` file in FileSystem panel  

---

**Ready? Open Godot and hit F5!** 🔥

