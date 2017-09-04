let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions.width = 384;
project.windowOptions.height = 384;
resolve(project);
