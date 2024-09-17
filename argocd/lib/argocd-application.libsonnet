local defaultProject = 'default';
local defaultRevision = 'HEAD';

local ArgoCDApplication(config={}, revision=defaultRevision) = {
  apiVersion: 'argoproj.io/v1alpha1',
  kind: 'Application',
  metadata: {
    name: config.name,
    namespace: 'argocd',
    finalizers: [
      'resources-finalizer.argocd.argoproj.io',
    ],
    annotations+: std.mergePatch(
      (if 'wave' in config then {
        'argocd.argoproj.io/sync-wave': config.wave,
      } else {}),
      (if 'serverSideDiff' in config then {
        'argocd.argoproj.io/compare-options': 'ServerSideDiff=' + config.serverSideDiff,
      } else {})
    ),
  },
  spec: {
    project: defaultProject,
    source: {
      repoURL: 'https://github.com/siutsin/otaru.git',
      path: std.get(config, 'path', 'helm-charts/' + config.name),
      targetRevision: revision,
      [if 'helm' in config then 'helm']: config.helm,
    },
    destination: {
      server: 'https://kubernetes.default.svc',
      namespace: std.get(config, 'namespace', 'argocd'),
    },
    syncPolicy: {
      automated: {
        prune: true,
        selfHeal: true,
      } + std.get(config, 'automated', {}),
      syncOptions: [
        'ServerSideApply=true',
        'CreateNamespace=true',
      ] + std.get(config, 'syncOptions', []),
    },
    [if 'ignoreDifferences' in config then 'ignoreDifferences']: config.ignoreDifferences,
  },
};
{
  new:: ArgoCDApplication,
}
