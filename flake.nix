{
  description = "My personal disko setups for different machines";

  outputs = {self, ...} @ inputs: {
    templates = {
      ymir = {
        path = ./machine/ymir;
      };
    };
  };
}
