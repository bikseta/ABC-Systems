resource "aws_codepipeline" "ghost" {
  name     = "ghost"
  role_arn = "arn:aws:iam::123456789012:role/CodePipelineServiceRole"

  artifact_store {
    type          = "S3"
    location      = "my-artifact-bucket"
    encryption_key = "arn:aws:kms:us-west-2:123456789012:key/abcd1234-5678-efgh-ijkl-mnopqrstuvwx"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        S3Bucket       = "my-source-bucket"
        S3ObjectKey    = "source.zip"
        PollForSourceChanges = "false"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = "my-build-project"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = aws_ecs_cluster.ghost.name
        ServiceName = aws_ecs_service.ghost.name
        FileName   = "imagedefinitions.json"
      }
    }
  }
}