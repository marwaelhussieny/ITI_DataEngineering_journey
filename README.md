<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITI Data Engineering Journey</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #0f0f1e;
            color: #e0e0e0;
            font-family: 'Courier New', monospace;
            overflow-x: hidden;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .title {
            text-align: center;
            margin: 40px 0;
            font-size: 2.5em;
            color: #00ff88;
            text-shadow: 0 0 10px #00ff88;
            cursor: pointer;
            transition: all 0.3s;
        }

        .title:hover {
            transform: scale(1.05);
            text-shadow: 0 0 20px #00ff88;
        }

        .pixel-canvas {
            background: #1a1a2e;
            border: 4px solid #00ff88;
            margin: 20px 0;
            box-shadow: 0 0 20px rgba(0, 255, 136, 0.3);
        }

        .zone {
            background: #16213e;
            border: 2px solid #0f4c75;
            margin: 20px 0;
            padding: 20px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .zone:hover {
            border-color: #00ff88;
            box-shadow: 0 0 15px rgba(0, 255, 136, 0.2);
            transform: translateX(5px);
        }

        .zone-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .zone-title {
            font-size: 1.3em;
            color: #00d4ff;
        }

        .zone-percent {
            color: #ff6b9d;
            font-weight: bold;
        }

        .progress-bar {
            height: 20px;
            background: #0a0a15;
            border: 1px solid #0f4c75;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #00ff88, #00d4ff);
            transition: width 1s ease;
            width: 0;
        }

        .skills {
            display: none;
            margin-top: 15px;
            padding-left: 20px;
        }

        .skill {
            margin: 8px 0;
            color: #a0a0a0;
            transition: color 0.3s;
        }

        .skill:hover {
            color: #00ff88;
        }

        .zone.active .skills {
            display: block;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 30px 0;
        }

        .stat-card {
            background: #16213e;
            padding: 15px;
            border: 2px solid #0f4c75;
            border-radius: 8px;
            text-align: center;
            transition: all 0.3s;
        }

        .stat-card:hover {
            border-color: #ff6b9d;
            transform: translateY(-5px);
        }

        .stat-value {
            font-size: 2em;
            color: #00ff88;
            margin: 10px 0;
        }

        .stat-label {
            color: #a0a0a0;
            font-size: 0.9em;
        }

        .footer {
            text-align: center;
            margin: 50px 0 20px;
            color: #666;
            font-size: 0.9em;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .floating {
            animation: float 3s ease-in-out infinite;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="title" onclick="drawRandomArt()">THE ITI DATA ENGINEERING JOURNEY</h1>
        
        <canvas class="pixel-canvas" id="pixelCanvas" width="800" height="200"></canvas>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Total Progress</div>
                <div class="stat-value">100%</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Skills Unlocked</div>
                <div class="stat-value">24</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Hours Invested</div>
                <div class="stat-value">500+</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Coffee Consumed</div>
                <div class="stat-value">∞</div>
            </div>
        </div>

        <div class="zone" onclick="toggleZone(this)" data-progress="25">
            <div class="zone-header">
                <div class="zone-title">FUNDAMENTALS</div>
                <div class="zone-percent">25%</div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
            <div class="skills">
                <div class="skill">→ Python Programming Language</div>
                <div class="skill">→ Introduction To Linux</div>
                <div class="skill">→ Database Fundamentals</div>
            </div>
        </div>

        <div class="zone" onclick="toggleZone(this)" data-progress="32">
            <div class="zone-header">
                <div class="zone-title">WORKING WITH DATA</div>
                <div class="zone-percent">32%</div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
            <div class="skills">
                <div class="skill">→ Data Analytics (Pandas, NumPy, Matplotlib)</div>
                <div class="skill">→ NoSQL Database</div>
                <div class="skill">→ Introduction to Big Data</div>
                <div class="skill">→ Data Warehouse Concepts</div>
                <div class="skill">→ Data Exploration & Visualization</div>
            </div>
        </div>

        <div class="zone" onclick="toggleZone(this)" data-progress="20">
            <div class="zone-header">
                <div class="zone-title">PROCESSING & SCHEDULING</div>
                <div class="zone-percent">20%</div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
            <div class="skills">
                <div class="skill">→ Data Processing Frameworks</div>
                <div class="skill">→ Workflow Scheduling</div>
                <div class="skill">→ CI/CD Pipelines</div>
            </div>
        </div>

        <div class="zone" onclick="toggleZone(this)" data-progress="5">
            <div class="zone-header">
                <div class="zone-title">CLOUD COMPUTING</div>
                <div class="zone-percent">5%</div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
            <div class="skills">
                <div class="skill">→ AWS Cloud Services</div>
            </div>
        </div>

        <div class="zone" onclick="toggleZone(this)" data-progress="7">
            <div class="zone-header">
                <div class="zone-title">WORKSHOPS</div>
                <div class="zone-percent">7%</div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
            <div class="skills">
                <div class="skill">→ Agile Fundamentals</div>
                <div class="skill">→ Software Testing</div>
                <div class="skill">→ OS Fundamentals</div>
                <div class="skill">→ Network Fundamentals</div>
            </div>
        </div>

        <div class="zone" onclick="toggleZone(this)" data-progress="11">
            <div class="zone-header">
                <div class="zone-title">SOFT SKILLS</div>
                <div class="zone-percent">11%</div>
            </div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
            <div class="skills">
                <div class="skill">→ Freelancing Skills</div>
                <div class="skill">→ Presentation Skills</div>
                <div class="skill">→ Communication Skills</div>
                <div class="skill">→ Interviewing Skills</div>
            </div>
        </div>

        <div class="footer">
            Click zones to expand | Click title for pixel art | Made with actual code, not templates
        </div>
    </div>

    <script>
        const canvas = document.getElementById('pixelCanvas');
        const ctx = canvas.getContext('2d');
        const pixelSize = 8;

        const sprites = {
            laptop: [
                [0,0,0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,1,1,0],
                [0,1,2,2,2,2,2,2,1,0],
                [0,1,2,2,2,2,2,2,1,0],
                [0,1,2,2,2,2,2,2,1,0],
                [0,1,1,1,1,1,1,1,1,0],
                [1,1,1,1,1,1,1,1,1,1],
            ],
            data: [
                [0,1,1,1,0],
                [1,0,0,0,1],
                [1,0,1,0,1],
                [1,0,0,0,1],
                [0,1,1,1,0],
            ],
            cloud: [
                [0,0,1,1,1,0,0],
                [0,1,0,0,0,1,0],
                [1,0,0,0,0,0,1],
                [0,1,1,1,1,1,0],
            ],
            rocket: [
                [0,0,1,0,0],
                [0,1,2,1,0],
                [0,1,2,1,0],
                [1,1,2,1,1],
                [1,0,2,0,1],
                [0,0,3,0,0],
                [0,3,0,3,0],
            ]
        };

        const colors = {
            0: '#0f0f1e',
            1: '#00ff88',
            2: '#00d4ff',
            3: '#ff6b9d'
        };

        function drawSprite(sprite, x, y) {
            sprite.forEach((row, i) => {
                row.forEach((pixel, j) => {
                    ctx.fillStyle = colors[pixel];
                    ctx.fillRect(x + j * pixelSize, y + i * pixelSize, pixelSize, pixelSize);
                });
            });
        }

        function drawRandomArt() {
            ctx.fillStyle = '#1a1a2e';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            drawSprite(sprites.laptop, 50, 50);
            drawSprite(sprites.data, 200, 60);
            drawSprite(sprites.cloud, 320, 50);
            drawSprite(sprites.rocket, 460, 40);
            drawSprite(sprites.data, 580, 60);
            drawSprite(sprites.laptop, 690, 50);

            // Random floating pixels
            for (let i = 0; i < 50; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                const color = Math.random() > 0.5 ? '#00ff88' : '#00d4ff';
                ctx.fillStyle = color;
                ctx.fillRect(x, y, 2, 2);
            }
        }

        function toggleZone(zone) {
            zone.classList.toggle('active');
            const progress = zone.getAttribute('data-progress');
            const fill = zone.querySelector('.progress-fill');
            
            if (zone.classList.contains('active')) {
                fill.style.width = progress + '%';
            } else {
                fill.style.width = '0%';
            }
        }

        // Initialize all progress bars on load
        window.addEventListener('load', () => {
            drawRandomArt();
            document.querySelectorAll('.zone').forEach(zone => {
                const progress = zone.getAttribute('data-progress');
                const fill = zone.querySelector('.progress-fill');
                setTimeout(() => {
                    fill.style.width = progress + '%';
                }, 300);
            });
        });

        // Redraw pixel art every 5 seconds with slight variations
        setInterval(() => {
            const zones = document.querySelectorAll('.zone');
            const anyActive = Array.from(zones).some(z => z.classList.contains('active'));
            if (!anyActive) {
                drawRandomArt();
            }
        }, 5000);
    </script>
</body>
</html>
