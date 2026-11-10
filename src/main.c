
volatile float pi = 3.14f;
int main(void){
  for(;;){
    pi += 0.001f;
  }
  return 0;
}
