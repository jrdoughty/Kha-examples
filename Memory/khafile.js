let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions.width = 256;
project.windowOptions.height = 256;
resolve(project);
