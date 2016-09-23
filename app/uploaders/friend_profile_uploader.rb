# encoding: utf-8

class FriendProfileUploader < CarrierWave::Uploader::Base

 include CarrierWaveDirect::Uploader
 
  storage :fog

  def fog_public
    false
  end

  def store_dir
    "friend-images"
  end

  def extension_white_list
    %w(jpg png)
  end
end
