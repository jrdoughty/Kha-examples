let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions.width = 128;
project.windowOptions.height = 128;
resolve(project);
