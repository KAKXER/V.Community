const setup = require('./setup.js');
const { start } = require('./bot.js');
const chalk = require('chalk');

const printValues = function(values, text) {
  console.log(text ? text : 'Current values:');
  for (var key in values) {
    console.log(`  ${key} = \x1b[32m'${values[key]}'\x1b[0m`);
  }
}

const startBot = function(values) {
  // console.log(`${chalk.bgBlue("[INFO]")} ${chalk.blue("Starting bot... this may take a few seconds to start...")}`);
  var bot = start(values);
  bot.on('restart',() => {
    console.log('\nRestarting bot');
    bot.destroy();
    bot = start(values);
  })
  var shutdown = function() {
    console.log(`${chalk.bgRed(`[STATUS]`)} ${chalk.red('Shutting down')}`);
    let destructor = bot.destroy();
    if (destructor) {
      destructor.then(() => {
        process.exit(0);
      }).catch(console.error);
    } else {
      process.exit(0);
    }
  }
  process.on('SIGINT', shutdown);
  process.on('SIGTERM', shutdown);
}

if (process.argv.includes('-c') || process.argv.includes('--config')) {
  setup.loadValues().then((values) => {
    printValues(values);
    process.exit(0);
  }).catch((error) => {
    console.log('Unable to load saved values, reconfiguring all saved values again');
    setup.createValues().then((values) => {
      setup.saveValues(values).then(() => {
        printValues(values, 'New values:');
        process.exit(0);
      }).catch(console.error);
    }).catch(console.error);
  })
} else {
  // console.log(`${chalk.bold.bgYellow(`[LOAD]`)} ${chalk.bold.yellow('Attempting to load enviroment values...')}`);
  setup.loadValues().then((values) => {
    startBot(values);
  }).catch((error) => {
    console.error(error);
    setup.createValues().then((values) => {
      setup.saveValues(values).then(() => {
        startBot(values);
      }).catch(console.error);
    }).catch(console.error);
  })
}
