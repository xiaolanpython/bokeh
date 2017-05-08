gulp = require "gulp"
taskList = require "gulp-task-listing"

utils = require "./utils"

chalk = require "chalk"
{TSError} = require "ts-node"

prettyTSError = (error) ->
  title = "#{chalk.red('⨯')} Unable to compile TypeScript"
  return "#{chalk.bold(title)}\n#{error.diagnostics.map((x) -> x.message).join('\n')}"

module.constructor.prototype.require = (modulePath) ->
  try
    return this.constructor._load(modulePath, this)
  catch err
    if err instanceof TSError
      console.error(prettyTSError(err))
      process.exit(1)
    else
      throw err

for tasks in utils.loadTasks "#{__dirname}/tasks/"
  for task in tasks
    require task.path

gulp.task "help", taskList
