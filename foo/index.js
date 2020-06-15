const {uuid} = require ('uuid');

exports.handler = asynch (event) => {
    return "This is simplest lambda for FOO :-" + uuid.v4();
}