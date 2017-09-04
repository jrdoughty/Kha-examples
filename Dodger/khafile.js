let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions.width = 640;
project.windowOptions.height = 400;
resolve(project);
