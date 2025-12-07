# QUBIX Demo Video Production Guide
## Complete Guide to Creating the Hackathon Demo

---

## Overview

This guide provides step-by-step instructions for producing a professional 5-7 minute demo video for the QUBIX hackathon submission.

**Goal**: Create a compelling demo that showcases QUBIX's key features and wins the "Qubic: Hack the Future" hackathon.

---

## Pre-Production Checklist

### 1. Software Requirements

#### Screen Recording:
- [ ] **OBS Studio** (Free, recommended) - https://obsproject.com/
- [ ] **Camtasia** (Paid, easier editing) - https://www.techsmith.com/
- [ ] **ScreenFlow** (Mac only) - https://www.telestream.net/

#### Video Editing:
- [ ] **DaVinci Resolve** (Free, professional) - https://www.blackmagicdesign.com/
- [ ] **Adobe Premiere Pro** (Paid, industry standard)
- [ ] **Final Cut Pro** (Mac only)

#### Audio Recording:
- [ ] **Audacity** (Free) - https://www.audacityteam.org/
- [ ] **Adobe Audition** (Paid)

#### Graphics:
- [ ] **Canva** (Free/Paid) - For title cards and graphics
- [ ] **Adobe After Effects** (Paid) - For advanced animations

### 2. Hardware Requirements

#### Essential:
- [ ] Computer with 1920x1080 display
- [ ] USB microphone (Blue Yeti, Audio-Technica AT2020, or similar)
- [ ] Headphones for monitoring
- [ ] Quiet recording environment

#### Optional:
- [ ] Pop filter for microphone
- [ ] Microphone stand or boom arm
- [ ] Acoustic treatment (foam panels)
- [ ] Second monitor for reference

### 3. Platform Setup

#### QUBIX Platform:
- [ ] Backend running on http://localhost:3001
- [ ] Frontend running on http://localhost:5173
- [ ] Database seeded with test data
- [ ] Provider account created with RTX 4090
- [ ] Consumer account with QUBIC balance
- [ ] Sample files ready (sample-mnist.py)

#### Browser Setup:
- [ ] Chrome or Firefox (latest version)
- [ ] All extensions disabled
- [ ] Bookmarks bar hidden
- [ ] Zoom set to 100%
- [ ] Clear cache and cookies
- [ ] Disable notifications

### 4. Test Data Preparation

#### Files:
- [ ] sample-mnist.py (2-3 KB)
- [ ] sample-stable-diffusion.py (if showing)
- [ ] Sample dataset (if needed)

#### Accounts:
- [ ] Provider: RTX 4090, $0.50/hr rate
- [ ] Consumer: 1,250 QUBIC balance
- [ ] Wallet addresses ready

---

## Production Phase

### Step 1: Record Narration (Audio Only)

**Why record audio first?**
- Easier to edit without video constraints
- Can re-record sections without re-doing screen captures
- Ensures consistent pacing

**Process:**
1. Set up microphone in quiet room
2. Close windows, turn off fans/AC
3. Use pop filter to reduce plosives
4. Record in Audacity or similar
5. Read script naturally (don't rush)
6. Leave 2-3 seconds between sections
7. Record multiple takes of difficult sections

**Audio Settings:**
- Sample Rate: 48000 Hz
- Bit Depth: 24-bit
- Format: WAV (lossless)
- Mono recording (voice)

**Post-Processing:**
1. Remove background noise
2. Normalize audio levels
3. Add compression (gentle)
4. EQ to enhance voice clarity
5. Export as WAV for editing

### Step 2: Record Screen Captures

**OBS Studio Setup:**

1. **Create Scene:**
   - Source: Display Capture (full screen)
   - Or: Window Capture (browser only)

2. **Video Settings:**
   - Base Resolution: 1920x1080
   - Output Resolution: 1920x1080
   - FPS: 60 (for smooth motion)

3. **Output Settings:**
   - Recording Format: MP4
   - Encoder: x264
   - Rate Control: CBR
   - Bitrate: 8000 Kbps
   - Preset: High Quality

4. **Audio Settings:**
   - Disable microphone (audio recorded separately)
   - Or: Record system audio only

**Recording Process:**

1. **Prepare Each Shot:**
   - Review shot list
   - Set up browser/app state
   - Practice actions 2-3 times
   - Start recording

2. **Record with Buffer:**
   - Start recording 5 seconds before action
   - Perform action smoothly (not too fast)
   - Hold final frame for 3 seconds
   - Stop recording

3. **Multiple Takes:**
   - Record each shot 2-3 times
   - Choose best take in editing
   - Don't worry about mistakes

4. **Organize Files:**
   - Name files: `shot-01-opening.mp4`
   - Store in organized folders
   - Back up immediately

**Key Shots to Record:**

1. Opening title (can be created in editing)
2. Provider registration flow
3. Hardware detection
4. Job submission with drag-and-drop
5. File upload and analysis
6. GPU marketplace and matching
7. GPU selection and cost breakdown
8. Escrow transaction creation
9. Qubic explorer view
10. Job monitoring dashboard
11. Live metrics and logs
12. Job completion
13. Provider earnings dashboard
14. Transaction history
15. Closing graphics (can be created in editing)

### Step 3: Record B-Roll (Optional)

**Additional footage to enhance video:**
- Close-ups of UI elements
- Smooth scrolling through pages
- Hover effects and animations
- Chart animations
- Transition shots

### Step 4: Create Graphics

**Title Cards:**
1. Opening title with QUBIX logo
2. Section dividers
3. Cost comparison graphics
4. Feature checklist
5. Closing call-to-action

**On-Screen Text:**
- "Hardware auto-detected in seconds"
- "72% cheaper than AWS!"
- "Real Qubic blockchain integration"
- "Try it now: demo.qubix.io"

**Tools:**
- Canva: Quick graphics and text
- After Effects: Animated graphics
- PowerPoint: Simple slides

**Export Settings:**
- Format: PNG with transparency
- Resolution: 1920x1080
- Or: MP4 for animated graphics

---

## Post-Production Phase

### Step 1: Import and Organize

**In Video Editor:**

1. **Create Project:**
   - Name: "QUBIX_Hackathon_Demo"
   - Resolution: 1920x1080
   - Frame Rate: 30fps (for final export)

2. **Import Media:**
   - All screen recordings
   - Narration audio
   - Background music
   - Graphics and title cards

3. **Organize Timeline:**
   - Video track 1: Main footage
   - Video track 2: Graphics/overlays
   - Audio track 1: Narration
   - Audio track 2: Background music
   - Audio track 3: Sound effects (optional)

### Step 2: Rough Cut

**Process:**

1. **Lay Down Narration:**
   - Place narration on audio track
   - This is your timing guide

2. **Add Video Clips:**
   - Match video to narration timing
   - Trim clips to fit
   - Leave gaps for graphics

3. **Add Graphics:**
   - Title cards
   - On-screen text
   - Arrows and highlights

4. **Review Pacing:**
   - Watch full video
   - Adjust timing
   - Remove dead space

### Step 3: Fine Cut

**Enhancements:**

1. **Transitions:**
   - Use subtle fades (0.5s)
   - Avoid flashy transitions
   - Consistency is key

2. **Zoom Effects:**
   - Zoom in on important UI elements
   - Use keyframe animation
   - Smooth easing (not linear)

3. **Highlights:**
   - Add colored boxes around elements
   - Use arrows to point
   - Animate in/out smoothly

4. **Text Animations:**
   - Fade in captions
   - Slide in statistics
   - Typewriter effect for URLs

### Step 4: Color Grading

**Basic Corrections:**

1. **Exposure:**
   - Ensure consistent brightness
   - Not too dark or blown out

2. **Color Balance:**
   - Correct any color casts
   - Ensure whites are white

3. **Saturation:**
   - Slightly increase for vibrancy
   - Don't overdo it

4. **Contrast:**
   - Add subtle contrast
   - Make UI elements pop

**Tools:**
- DaVinci Resolve: Professional color grading
- Premiere Pro: Lumetri Color panel
- Final Cut Pro: Color Board

### Step 5: Audio Mixing

**Levels:**

1. **Narration:**
   - Peak at -6dB
   - Average at -12dB
   - Clear and prominent

2. **Background Music:**
   - Peak at -20dB
   - Average at -24dB
   - Subtle, not distracting

3. **Sound Effects:**
   - Peak at -12dB
   - Use sparingly

**Mixing Tips:**
- Duck music when narration plays
- Fade music in/out smoothly
- Remove any audio pops or clicks
- Ensure consistent volume throughout

### Step 6: Add Captions

**Why Add Captions:**
- Accessibility
- Better engagement (many watch muted)
- Professional appearance

**Process:**

1. **Import SRT File:**
   - Use provided DEMO_CAPTIONS.srt
   - Or: Auto-generate in editor
   - Or: Manually create

2. **Style Captions:**
   - Font: Arial Bold or similar
   - Size: 48pt
   - Color: White
   - Outline: Black, 4px
   - Position: Bottom center

3. **Timing:**
   - Captions appear 0.5s before speech
   - Stay on screen 2-3 seconds
   - Smooth fade in/out

### Step 7: Add Background Music

**Music Selection:**

**Royalty-Free Sources:**
- YouTube Audio Library
- Epidemic Sound
- Artlist
- Bensound
- Free Music Archive

**Recommended Tracks:**
- "Tech Innovation" by Bensound
- "Digital Future" by Audionautix
- "Upbeat Corporate" by AShamaluevMusic

**Music Placement:**

1. **Intro (0:00-0:30):**
   - Upbeat, energetic
   - Full volume (with narration)

2. **Main Content (0:30-6:00):**
   - Subtle background
   - Duck under narration
   - Maintain energy

3. **Outro (6:00-6:30):**
   - Build to climax
   - Fade out at end

### Step 8: Final Review

**Checklist:**

- [ ] Watch full video start to finish
- [ ] Check audio levels (no clipping)
- [ ] Verify all captions are readable
- [ ] Ensure smooth transitions
- [ ] Check for any glitches or errors
- [ ] Verify all links/URLs are correct
- [ ] Test on different devices
- [ ] Get feedback from team

**Common Issues to Fix:**
- Audio sync problems
- Abrupt cuts
- Inconsistent volume
- Typos in text
- Missing graphics
- Poor color balance

---

## Export Settings

### Final Export (1080p HD)

**Video:**
- Format: MP4 (H.264)
- Resolution: 1920x1080
- Frame Rate: 30fps
- Bitrate: 8 Mbps (CBR or VBR)
- Profile: High
- Level: 4.2

**Audio:**
- Codec: AAC
- Sample Rate: 48000 Hz
- Bitrate: 192 kbps
- Channels: Stereo

**File Size:**
- Target: 200-400 MB for 6-7 minutes
- Max: 500 MB

### Platform-Specific Exports

**YouTube:**
- Same as above
- Add metadata in YouTube Studio

**Vimeo:**
- Same as above
- Higher bitrate acceptable (10-12 Mbps)

**Twitter:**
- Max 2:20 duration (create shorter version)
- Max 512 MB file size

**LinkedIn:**
- Max 10 minutes
- Max 5 GB file size

---

## Distribution

### 1. Upload to Platforms

**YouTube:**
1. Create compelling thumbnail
2. Write detailed description
3. Add relevant tags
4. Set to "Public" or "Unlisted"
5. Add to playlist

**Vimeo:**
1. Upload in highest quality
2. Add description and tags
3. Enable download (optional)

**GitHub:**
1. Add link to README
2. Embed video or link

### 2. Create Thumbnail

**Design:**
- Size: 1280x720
- Format: JPG or PNG
- File size: <2 MB

**Elements:**
- QUBIX logo
- "72% Cheaper" text (large)
- Screenshot of dashboard
- "Hackathon Demo" badge

**Tools:**
- Canva
- Photoshop
- GIMP (free)

### 3. Write Description

**Template:**

```
QUBIX - Decentralized GPU Marketplace | Qubic Hackathon Demo

Watch how QUBIX revolutionizes GPU compute with 70% cost savings compared to AWS, powered by the Qubic blockchain.

🎯 Key Features:
• Drag-and-drop job submission
• Intelligent GPU matching
• Real Qubic blockchain integration
• Escrow payment protection
• Real-time monitoring dashboards
• Live earnings tracking

💰 Cost Comparison:
• AWS: $0.18 for MNIST training
• QUBIX: $0.05 for same job
• Savings: 72%

🔗 Links:
• Live Demo: demo.qubix.io
• GitHub: github.com/qubix-platform
• Documentation: docs.qubix.io

🏆 Built for "Qubic: Hack the Future" Hackathon
Competing for $44,550 in prizes

⏱️ Timestamps:
0:00 - Introduction
0:30 - Provider Onboarding
1:30 - Job Submission
2:45 - Smart GPU Matching
3:45 - Blockchain Integration
4:30 - Real-Time Monitoring
5:30 - Provider Earnings
6:00 - Cost Comparison

#Qubic #Blockchain #GPU #MachineLearning #Hackathon #Decentralized
```

---

## Quality Assurance

### Technical Checks

- [ ] Video plays smoothly (no stuttering)
- [ ] Audio is clear and balanced
- [ ] Captions are accurate and timed correctly
- [ ] All graphics are high resolution
- [ ] No compression artifacts
- [ ] Colors are accurate
- [ ] Aspect ratio is correct (16:9)

### Content Checks

- [ ] All features demonstrated
- [ ] Cost comparison is clear
- [ ] Blockchain integration shown
- [ ] Real-time updates visible
- [ ] All claims are accurate
- [ ] No typos or errors
- [ ] Branding is consistent

### Audience Testing

- [ ] Show to 3-5 people
- [ ] Get feedback on clarity
- [ ] Check if message is compelling
- [ ] Verify technical accuracy
- [ ] Ensure pacing is good
- [ ] Confirm call-to-action is clear

---

## Backup Plan

### If Recording Fails

**Option 1: Slides + Voiceover**
- Create detailed slides
- Record voiceover
- Add transitions and animations

**Option 2: Screen Recording Only**
- Record without narration
- Add captions and text
- Use background music

**Option 3: Live Demo**
- Record live presentation
- Edit out mistakes
- Add graphics in post

### If Time is Limited

**Priority Features to Show:**
1. ✅ Drag-and-drop upload (must have)
2. ✅ Smart GPU matching (must have)
3. ✅ Blockchain transaction (must have)
4. ✅ Cost comparison (must have)
5. ⚠️ Real-time monitoring (nice to have)
6. ⚠️ Provider earnings (nice to have)

**Minimum Viable Demo:**
- 3-4 minutes
- Show core workflow
- Emphasize cost savings
- Prove blockchain integration

---

## Timeline

### Recommended Schedule

**Day 1: Pre-Production (4 hours)**
- Set up software and hardware
- Prepare platform and test data
- Practice recording
- Record narration

**Day 2: Production (6 hours)**
- Record all screen captures
- Create graphics
- Organize files
- Backup everything

**Day 3: Post-Production (8 hours)**
- Import and organize
- Rough cut
- Fine cut with effects
- Color grading

**Day 4: Finishing (4 hours)**
- Audio mixing
- Add captions
- Final review
- Export

**Day 5: Distribution (2 hours)**
- Upload to platforms
- Create thumbnail
- Write descriptions
- Share with team

**Total: 24 hours over 5 days**

---

## Tips for Success

### Recording Tips

1. **Practice First:**
   - Do dry runs before recording
   - Know exactly what you'll do
   - Smooth, deliberate movements

2. **Slow Down:**
   - Move cursor slowly
   - Pause between actions
   - Give viewers time to see

3. **Be Consistent:**
   - Use same browser window
   - Keep UI consistent
   - Maintain same zoom level

4. **Record Extras:**
   - Get multiple takes
   - Record B-roll
   - Capture backup footage

### Editing Tips

1. **Less is More:**
   - Cut unnecessary content
   - Keep it concise
   - Every second counts

2. **Smooth Transitions:**
   - Use subtle effects
   - Maintain flow
   - Don't distract from content

3. **Emphasize Key Points:**
   - Zoom on important elements
   - Use highlights sparingly
   - Let visuals speak

4. **Professional Polish:**
   - Consistent branding
   - Clean graphics
   - Quality audio

### Narration Tips

1. **Be Enthusiastic:**
   - Show passion for project
   - Smile while recording (it shows)
   - Vary your tone

2. **Speak Clearly:**
   - Enunciate words
   - Don't rush
   - Pause between sentences

3. **Be Natural:**
   - Conversational tone
   - Avoid reading robotically
   - Inject personality

---

## Resources

### Free Music Sources
- YouTube Audio Library: https://www.youtube.com/audiolibrary
- Bensound: https://www.bensound.com/
- Free Music Archive: https://freemusicarchive.org/

### Free Sound Effects
- Freesound: https://freesound.org/
- Zapsplat: https://www.zapsplat.com/
- BBC Sound Effects: https://sound-effects.bbcrewind.co.uk/

### Stock Footage (if needed)
- Pexels: https://www.pexels.com/videos/
- Pixabay: https://pixabay.com/videos/
- Videvo: https://www.videvo.net/

### Learning Resources
- OBS Studio Tutorial: https://obsproject.com/wiki/
- DaVinci Resolve Training: https://www.blackmagicdesign.com/products/davinciresolve/training
- Video Editing Basics: YouTube tutorials

---

## Final Checklist

Before submitting:

- [ ] Video is 5-7 minutes long
- [ ] Exported in 1080p HD
- [ ] File size is reasonable (<500 MB)
- [ ] Audio is clear and balanced
- [ ] Captions are included
- [ ] All features are demonstrated
- [ ] Cost comparison is shown
- [ ] Blockchain integration is proven
- [ ] Call-to-action is clear
- [ ] Thumbnail is created
- [ ] Description is written
- [ ] Uploaded to platform(s)
- [ ] Link is tested
- [ ] Team has reviewed
- [ ] Ready for submission!

---

## Contact for Help

If you need assistance:
- Video editing questions: [Your contact]
- Technical issues: [Your contact]
- Content questions: [Your contact]

**Good luck with your demo video! 🎬🚀**
