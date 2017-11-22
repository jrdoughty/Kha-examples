let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions.width = 512;
project.windowOptions.height = 512;
resolve(project);
