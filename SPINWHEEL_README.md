# 🎯 Spinwheel Feature - Student Platform

## Overview
The spinwheel feature allows students to spin a wheel once per day to win points, enhancing student engagement and providing a fun way to earn rewards.

## Features

### For Students
- **Daily Spin**: Students can spin the wheel once per day
- **Point Rewards**: Win various amounts of points based on probability weights
- **Visual Feedback**: Beautiful animated spinwheel with colorful segments
- **Spin History**: View previous spin results and points earned
- **Dashboard Integration**: Quick access from the student dashboard

### For Admins
- **Create Spinwheels**: Design custom spinwheels with multiple prize segments
- **Manage Items**: Add, edit, and remove prize items with custom probabilities
- **Activate/Deactivate**: Control which spinwheels are available to students
- **Monitor Usage**: Track spinwheel usage and student engagement

## How It Works

### Student Experience
1. **Access**: Click "Spin Now" from the student dashboard
2. **Choose**: Select from available spinwheels
3. **Spin**: Click the spin button to rotate the wheel
4. **Win**: Receive points based on where the wheel stops
5. **Daily Limit**: Can only spin once per day (resets at midnight)

### Admin Management
1. **Create Spinwheel**: Set name, description, and status
2. **Add Items**: Configure prize items with:
   - Label (e.g., "10 Points", "Special Reward")
   - Point value
   - Probability weight (higher = more likely to win)
   - Color for visual representation
3. **Activate**: Make spinwheel available to students
4. **Monitor**: Track usage and adjust as needed

## Technical Implementation

### Database Models
- **SpinWheel**: Main spinwheel entity with metadata
- **SpinWheelItem**: Individual prize items with probabilities
- **SpinWheelHistory**: Records of all spins and results

### Key Components
- **Controllers**: Handle admin and student spinwheel operations
- **Services**: Business logic for spinwheel operations
- **Views**: JSP templates for admin and student interfaces
- **JavaScript**: Interactive spinwheel animations

### Security Features
- **Session-based access control**
- **Daily spin limit enforcement**
- **Admin-only management functions**

## Usage Examples

### Creating a Spinwheel
1. Admin logs in and navigates to Spinwheel Management
2. Clicks "Create New Spinwheel"
3. Fills in name (e.g., "Daily Rewards")
4. Adds description (e.g., "Spin to win points every day!")
5. Saves the spinwheel

### Adding Prize Items
1. Edit the spinwheel
2. Click "Add Item"
3. Configure each item:
   - **10 Points** (Weight: 40, Color: #ff6b6b)
   - **25 Points** (Weight: 25, Color: #4ecdc4)
   - **50 Points** (Weight: 20, Color: #45b7d1)
   - **100 Points** (Weight: 10, Color: #96ceb4)
   - **200 Points** (Weight: 4, Color: #feca57)
   - **500 Points** (Weight: 1, Color: #ff9ff3)

### Student Spinning
1. Student visits dashboard and sees "Lucky Spin" section
2. Clicks "Spin Now" to go to spinwheel list
3. Selects desired spinwheel
4. Clicks "SPIN THE WHEEL!" button
5. Watches wheel spin and sees result
6. Receives points automatically

## Configuration

### Probability Weights
- Higher weights = higher chance of winning
- Total weight determines probability distribution
- Example: Item with weight 10 has 10x higher chance than weight 1

### Colors
- Each segment can have a custom color
- Use hex color codes (e.g., #ff6b6b)
- Colors should provide good contrast for text readability

### Daily Reset
- Spin limit resets at midnight local time
- Based on server's timezone
- Students can spin again the next day

## Troubleshooting

### Common Issues
1. **"Already Spun Today"**: Wait until tomorrow or check server time
2. **No Spinwheels Available**: Admin needs to create and activate spinwheels
3. **Wheel Not Spinning**: Check JavaScript console for errors
4. **Points Not Awarded**: Verify database connection and service configuration

### Admin Tips
- Test spinwheels before activating them
- Monitor point distribution to ensure fair gameplay
- Use probability weights to control reward distribution
- Consider seasonal or themed spinwheels for engagement

## Future Enhancements
- **Multiple Daily Spins**: Allow multiple spins with decreasing rewards
- **Special Events**: Time-limited spinwheels with bonus rewards
- **Social Features**: Share results with friends
- **Achievements**: Unlock special spinwheels through participation
- **Analytics**: Detailed reporting on spinwheel usage and effectiveness

## Support
For technical support or feature requests, contact the development team or create an issue in the project repository.
