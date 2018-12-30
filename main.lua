--[[
Button Clicking Game
Created for "Lua Programming and Game Development with LOVE" course on Udemy.
Additional features and improvements made by Gina Ribniscky.

Udemy Course: https://www.udemy.com/lua-love/
]]

function love.load()
	constants = {};
	constants.gameStateMainMenu = 1;
	constants.gameStateRunning = 2;
	constants.fontSize = 40;
	constants.font = love.graphics.newFont(constants.fontSize);
	constants.padding = 10;
	constants.minButtonSize = 5;
	constants.buttonRadius = 50;
	constants.buttonX = 200;
	constants.buttonY = 200;
	constants.buttonSizeDecreaseRate = 10;

	defaults = {};
	defaults.gameState = constants.gameStateMainMenu;
	defaults.timer = 10;
	defaults.score = 0;

	button = {};
	button.x = constants.buttonX;
	button.y = constants.buttonY;
	button.size = constants.buttonRadius;

	gm = {};
	gm.score = defaults.score;
	gm.timer = defaults.timer;
	gm.state = defaults.gameState;
end

function love.update(dt)
	if gm.state == constants.gameStateRunning then
		if gm.timer > 0 then
			gm.timer = gm.timer - dt;

			if button.size >= constants.minButtonSize then
				button.size = button.size - dt * constants.buttonSizeDecreaseRate;
			end
		end

		if gm.timer < 0 then
			resetGame();
		end
	end
end

function love.draw()
	if gm.state == constants.gameStateRunning then
		love.graphics.setColor(1, 0, 0);
		love.graphics.circle("fill", button.x, button.y, button.size);
	end

	love.graphics.setFont(constants.font);
	love.graphics.setColor(1, 1, 1);
	love.graphics.print("Score: " .. gm.score, constants.padding, constants.padding);
	love.graphics.printf("Time: " .. math.ceil(gm.timer), 0, constants.padding, love.graphics.getWidth()-constants.padding, "right");

	if gm.state == 1 then
		love.graphics.printf("Click anywhere to begin.", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center");
	end
end

function love.mousepressed( x, y, b, istouch )
	if b == 1 and gm.state == constants.gameStateRunning then
		if distanceBetween(love.mouse.getX(), love.mouse.getY(), button.x, button.y) < button.size then
			gm.score = gm.score + 1
			setButtonPosition();
		end
	end

	if gm.state == constants.gameStateMainMenu then
		startGame();
	end
end

function distanceBetween(x1, y1, x2, y2)
	return math.sqrt((y2-y1)^2 + (x2-x1)^2);
end

function setButtonPosition()
	button.size = constants.buttonRadius;
	button.x = math.random(button.size, love.graphics.getWidth() - button.size);
	button.y = math.random(button.size + constants.fontSize, love.graphics.getHeight() - button.size);
end

function startGame()
	gm.timer = defaults.timer;
	gm.state = constants.gameStateRunning;
	setButtonPosition();
end

function resetGame()
	gm.timer = defaults.timer;
	gm.state = constants.gameStateMainMenu;
	gm.score = defaults.score;
end
