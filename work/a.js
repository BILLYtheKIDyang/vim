function doAsyncTask(cb) {
   //cb();
   //setImmediate(() => { console.log("Async Task Calling Callback"); cb(); });
   process.nextTick(() => { console.log("Async Task Calling Callback"); cb(); });
}
doAsyncTask(_ => console.log(message));
let message = "Callback Called";
