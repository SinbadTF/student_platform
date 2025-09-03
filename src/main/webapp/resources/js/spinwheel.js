/**
 * Spinwheel JavaScript Library
 * Provides interactive spinwheel functionality for the student platform
 */

class SpinWheel {
    constructor(canvasId, items, options = {}) {
        this.canvas = document.getElementById(canvasId);
        this.ctx = this.canvas.getContext('2d');
        this.items = items;
        this.options = {
            radius: options.radius || 180,
            centerColor: options.centerColor || '#fff',
            centerBorderColor: options.centerBorderColor || '#dc3545',
            centerText: options.centerText || 'SPIN',
            textColor: options.textColor || '#fff',
            borderColor: options.borderColor || '#fff',
            borderWidth: options.borderWidth || 2,
            ...options
        };
        
        this.isSpinning = false;
        this.currentRotation = 0;
        this.centerX = this.canvas.width / 2;
        this.centerY = this.canvas.height / 2;
        
        this.init();
    }
    
    init() {
        this.drawWheel();
        this.addEventListeners();
    }
    
    drawWheel() {
        // Clear canvas
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        
        // Calculate total weight
        const totalWeight = this.items.reduce((sum, item) => sum + item.probabilityWeight, 0);
        
        // Draw segments
        let currentAngle = 0;
        this.items.forEach((item, index) => {
            const segmentAngle = (item.probabilityWeight / totalWeight) * 2 * Math.PI;
            
            // Draw segment
            this.ctx.beginPath();
            this.ctx.moveTo(this.centerX, this.centerY);
            this.ctx.arc(this.centerX, this.centerY, this.options.radius, currentAngle, currentAngle + segmentAngle);
            this.ctx.closePath();
            this.ctx.fillStyle = item.color || '#007bff';
            this.ctx.fill();
            this.ctx.strokeStyle = this.options.borderColor;
            this.ctx.lineWidth = this.options.borderWidth;
            this.ctx.stroke();
            
            // Draw text
            this.drawSegmentText(item, currentAngle, segmentAngle);
            
            currentAngle += segmentAngle;
        });
        
        // Draw center circle
        this.drawCenter();
    }
    
    drawSegmentText(item, startAngle, segmentAngle) {
        this.ctx.save();
        this.ctx.translate(this.centerX, this.centerY);
        this.ctx.rotate(startAngle + segmentAngle / 2);
        
        // Draw label
        this.ctx.textAlign = 'center';
        this.ctx.fillStyle = this.options.textColor;
        this.ctx.font = 'bold 14px Arial';
        this.ctx.fillText(item.label, this.options.radius * 0.7, 0);
        
        // Draw points
        this.ctx.font = '12px Arial';
        this.ctx.fillText(item.pointValue + ' pts', this.options.radius * 0.5, 20);
        
        this.ctx.restore();
    }
    
    drawCenter() {
        // Center circle
        this.ctx.beginPath();
        this.ctx.arc(this.centerX, this.centerY, 30, 0, 2 * Math.PI);
        this.ctx.fillStyle = this.options.centerColor;
        this.ctx.fill();
        this.ctx.strokeStyle = this.options.centerBorderColor;
        this.ctx.lineWidth = 3;
        this.ctx.stroke();
        
        // Center text
        this.ctx.fillStyle = this.options.centerBorderColor;
        this.ctx.font = 'bold 16px Arial';
        this.ctx.textAlign = 'center';
        this.ctx.fillText(this.options.centerText, this.centerX, this.centerY + 5);
    }
    
    spin() {
        if (this.isSpinning) return null;
        
        this.isSpinning = true;
        
        // Select random item based on probability weights
        const selectedItem = this.selectRandomItem();
        const selectedIndex = this.items.findIndex(item => item === selectedItem);
        
        // Calculate final rotation
        const segmentAngle = (2 * Math.PI) / this.items.length;
        const targetAngle = selectedIndex * segmentAngle + segmentAngle / 2;
        const finalRotation = 360 * 5 + (360 - (targetAngle * 180 / Math.PI));
        // Apply spinning animation
        this.canvas.style.setProperty('--final-rotation', finalRotation + 'deg');
        this.canvas.classList.add('spinning');
        
        return new Promise((resolve) => {
            setTimeout(() => {
                this.isSpinning = false;
                this.canvas.classList.remove('spinning');
                resolve(selectedItem);
            }, 3000);
        });
    }
    
    selectRandomItem() {
        const totalWeight = this.items.reduce((sum, item) => sum + item.probabilityWeight, 0);
        let random = Math.random() * totalWeight;
        
        for (let i = 0; i < this.items.length; i++) {
            random -= this.items[i].probabilityWeight;
            if (random <= 0) {
                return this.items[i];
            }
        }
        
        return this.items[this.items.length - 1];
    }
    
    addEventListeners() {
        // Add any additional event listeners here
    }
    
    // Utility methods
    resize(newWidth, newHeight) {
        this.canvas.width = newWidth;
        this.canvas.height = newHeight;
        this.centerX = newWidth / 2;
        this.centerY = newHeight / 2;
        this.drawWheel();
    }
    
    updateItems(newItems) {
        this.items = newItems;
        this.drawWheel();
    }
}

// Utility functions
const SpinWheelUtils = {
    // Format points with proper suffix
    formatPoints(points) {
        if (points >= 1000) {
            return (points / 1000).toFixed(1) + 'k';
        }
        return points.toString();
    },
    
    // Get random color if none provided
    getRandomColor() {
        const colors = [
            '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7',
            '#DDA0DD', '#98D8C8', '#F7DC6F', '#BB8FCE', '#85C1E9'
        ];
        return colors[Math.floor(Math.random() * colors.length)];
    },
    
    // Animate number counting
    animateNumber(element, start, end, duration = 1000) {
        const startTime = performance.now();
        const animate = (currentTime) => {
            const elapsed = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);
            
            const current = Math.floor(start + (end - start) * progress);
            element.textContent = current;
            
            if (progress < 1) {
                requestAnimationFrame(animate);
            }
        };
        requestAnimationFrame(animate);
    }
};

// Export for use in other files
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { SpinWheel, SpinWheelUtils };
}